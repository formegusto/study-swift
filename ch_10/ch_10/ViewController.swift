//
//  ViewController.swift
//  ch_10
//
//  Created by formegusto on 2021/12/05.
//

import UIKit
import CoreData

class ViewController: UIViewController  {

    @IBOutlet weak var todoTableView: UITableView!
    
    // UIApplication 은 가장 베이스가 되는 세팅이 담겨져 있는 라이프사이클이라고 생각하면 된다.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var todoList = [TodoList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationBar()
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
        
        fetchData()
        self.todoTableView.reloadData()
    }
    
    func fetchData() {
        // Core Data 개념 알아보기
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            let todoData = try context.fetch(fetchRequest)
            self.todoList = todoData
        } catch {
            print(error)
        }
        
    }
    
    func makeNavigationBar() {
        self.title = "To do List"
        
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        item.tintColor = .white
        self.navigationItem.rightBarButtonItem = item
        
        let barAppearance = UINavigationBarAppearance()

        barAppearance.configureWithDefaultBackground()
        barAppearance.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        // 2개 다 넣어줘야 되는 거같음,, ㅎ
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }

    @objc func addNewTodo() {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.topTitleLabel.text = todoList[indexPath.row].title
        if let hasDate = todoList[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd hh:mm:ss"
            let dateString = formatter.string(from: hasDate)
            cell.bottomDateLabel.text = dateString
        } else {
            cell.bottomDateLabel.text = ""
        }
        
        return cell
    }
    
    
}

