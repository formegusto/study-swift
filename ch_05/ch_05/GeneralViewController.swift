/*
 XIB 기반이 아닌,
 Storyboard 기반으로 만들거다. 때문에 New File에서
 Storyboard 파일도 만들어준다.
 */
import UIKit

// TableViewCell 생성한 것과 연결
// 및 Identifier 값: GeneralCell
// 밖에서 사용할 필요가없기 때문에 같은 클래스에 넣어서 해준다.
class GeneralCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    
    // 고정되어 있는 하나의 이미지일 때,
    // Property Observer 라는 개념을 사용한다.
    // didSet 메모리에 적재되거나, 새로운 무언가가 세팅 될 때 호출되는 메서드
    @IBOutlet weak var rightImage: UIImageView! {
        didSet {
            rightImage.image = UIImage.init(systemName: "chevron.right")
            rightImage.tintColor = .lightGray
            rightImage.backgroundColor = .clear
        }
    }
    
    
}

// GeneralViewController 에서만 사용할 거기 때문에 따로 빼지않고,
// 안에다가 Model을 정의한다.
struct GeneralModel {
    var title: String = ""
}

class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[GeneralModel]]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath) as! GeneralCell
        cell.leftLabel.text = model[indexPath.section][indexPath.row].title
        
        return cell
    }
    
    
    @IBOutlet weak var generalTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "General"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        // 직접 연결해서 가져왔기 때문에 register 할 필요가 없다.
        // 대신 delegate와 datasource는 설정해주어야 한다.
        generalTableView.delegate = self
        generalTableView.dataSource = self
        
        model.append([GeneralModel(title: "About")])
        
        model.append([
            GeneralModel(title: "Keyboard"),
            GeneralModel(title: "Game Controller"),
            GeneralModel(title: "Fonts"),
            GeneralModel(title: "Language & Region"),
            GeneralModel(title: "Dictionary")
        ])
        
        model.append([GeneralModel(title: "Reset")])
        
        self.generalTableView.backgroundColor = UIColor(white: 244/255, alpha: 1)
        self.view.backgroundColor = UIColor(white: 244/255, alpha: 1)
        
    }

}
