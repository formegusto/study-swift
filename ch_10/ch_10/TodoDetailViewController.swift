//
//  TodoDetailViewController.swift
//  ch_10
//
//  Created by formegusto on 2021/12/07.
//

import UIKit
import CoreData

// 돌아갈 화면의 tableView reload를 위한 protocol
protocol TodoDetailViewControllerDelegate: AnyObject {
    func didFinishSaveData()
}

class TodoDetailViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    weak var delegate: TodoDetailViewControllerDelegate?
    
    @IBOutlet weak var lowBtn: UIButton!
    @IBOutlet weak var normalBtn: UIButton!
    @IBOutlet weak var highBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var selectedTodoList: TodoList?
    var priority: PriorityLevel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        // viewDidLoad 에서 하면 화면에 딱 떨어지지 않을 수 있기 때문에
        // 해당 라이프사이클에서 진행
        self.lowBtn.layer.cornerRadius = lowBtn.bounds.height / 2
        self.normalBtn.layer.cornerRadius = normalBtn.bounds.height / 2
        self.highBtn.layer.cornerRadius = highBtn.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let hasData = selectedTodoList {
            titleTextField.text = hasData.title
            priority = PriorityLevel(rawValue: hasData.priorityLevel)
            setPriorityBtnView()
            self.saveBtn.setTitle("Save", for: .normal)
            self.deleteBtn.isHidden = false
        } else {
            self.saveBtn.setTitle("Update", for: .normal)
            self.deleteBtn.isHidden = true
        }
    }

    // Button View 설정탭에 Tag 설정할 수 있음.
    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
        default:
            break
        }
        
        setPriorityBtnView()
    }
    
    func setPriorityBtnView() {
        buttonColorClearn()
        
        var targetBtn: UIButton?
        
        switch priority {
        case .level1:
            targetBtn = lowBtn
        case .level2:
            targetBtn = normalBtn
        case .level3:
            targetBtn = highBtn
        default:
            break
        }
        
        targetBtn?.backgroundColor = .white.withAlphaComponent(0.3)
        targetBtn?.tintColor = priority?.color
    }
    
    func buttonColorClearn() {
        self.lowBtn.backgroundColor = .clear
        self.normalBtn.backgroundColor = .clear
        self.highBtn.backgroundColor = .clear
    }
    
    @IBAction func saveTodo(_ sender: Any) {
        if selectedTodoList != nil {
            self.updateTodo()
        } else {
            self.saveTodo()
        }
        
        self.delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    @IBAction func deleteTodo(_ sender: Any) {
        guard let hasData = selectedTodoList else {
            return
        }
        guard let hasUUID = hasData.uuid else {
            return
        }
            
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        // 조건걸기
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            if let firstData = loadedData.first {
                context.delete(firstData)
            }
            
            appDelegate.saveContext()
        } catch {
            print(error)
        }
        
        self.delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    func saveTodo() {
        // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // AppDelegate 쪽에 만들어놓은 것이 있어서 설정할 필요가 없다.
        // context.save()
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else {
            return
        }
        
        // 구조를 가지고 온다.
        guard let todoObject = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else {
            return
        }
        todoObject.title = titleTextField.text
        todoObject.date = Date() // 사용 시, 현재 날짜 저장
        todoObject.uuid = UUID() // 사용 시, 중복되지 않는 값 저장
        todoObject.priorityLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue

        appDelegate.saveContext()
    }
    
    func updateTodo() {
        guard let hasData = selectedTodoList else {
            return
        }
        guard let hasUUID = hasData.uuid else {
            return
        }
            
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        // 조건걸기
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            if let firstData = loadedData.first {
                firstData.title = titleTextField.text
                firstData.date = Date()
                firstData.priorityLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue
            }
            
            appDelegate.saveContext()
        } catch {
            print(error)
        }
    }
    
}
