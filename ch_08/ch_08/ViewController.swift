import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationItem()
        
        /*
         Collection View Layout 잡기
         UIScreen : 화면 크기 구해주는 클래스
         */
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width:UIScreen.main.bounds.width / 2 - 0.5, height: UIScreen.main.bounds.width / 2 - 1)
//        collectionViewLayout.itemSize = (CGSize(width:UIScreen.main.bounds.width -1 )/ 2, height: UIScreen.main.bounds.width / 2 - 1)

        // 일정간격이 있기 때문에 없애준다. (이쁘게 나오려면 )
        collectionViewLayout.minimumInteritemSpacing = 1
        collectionViewLayout.minimumLineSpacing = 1
        
        self.photoCollectionView.collectionViewLayout = collectionViewLayout
        
        self.photoCollectionView.dataSource = self
    }
    
    func setNavigationItem() {
        self.title = "Photo Gallery App"
        
        // Navigation Item
        /*
         Navigation Bar 를 다룰 수 있다.
         */
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .done, target: self, action: #selector(showGallery))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refreshImage))
        refreshItem.tintColor = .systemBlue
        self.navigationItem.leftBarButtonItem = refreshItem
    }

    @objc func showGallery() {
        
    }
    
    @objc func refreshImage() {
        
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        return cell
    }
    
    
}
