import UIKit
import PhotosUI

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
//        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .done, target: self, action: #selector(showGallery))
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .done, target: self, action: #selector(checkPermission))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refreshImage))
        refreshItem.tintColor = .systemBlue
        self.navigationItem.leftBarButtonItem = refreshItem
    }

    @objc func showGallery() {
        // import PhotoUI
        let library = PHPhotoLibrary.shared()
        
        var configuration = PHPickerConfiguration(photoLibrary: library)
        // 선택할 수 있는 사진 개수
        configuration.selectionLimit = 10
        
        let picker = PHPickerViewController(configuration: configuration)
        
        /*
         테스팅 모드라 권한설정부분이 안나올텐데,
         반드시 처리해주어야 한다.
         */
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func refreshImage() {
        
    }

    @objc func checkPermission() {
        /*
         authorized : 모든 권한을 가지고 있음
         denied : 사용자가 거부한 상태
         limited : 제한적으로 사진을 볼 수 있는 상태
         notDetermined : 권한에 관해 물어보지도 않은 상태 (설정전)
         restricted : 지역마다 사용할 수 있는? 그런느낌으로
         */
        if (PHPhotoLibrary.authorizationStatus() == .authorized) ||
            (PHPhotoLibrary.authorizationStatus() == .limited) {
            DispatchQueue.main.async {
                // 화면을 건드는 부분이라 main thread에서 동작해야한다.
                // 밑에 클로저가 실행되면 다른 thread 에서 실행되므로,
                // main에서 실행되게끔 DispatchQueue를 이용해준다.
                self.showGallery()
            }
        } else if PHPhotoLibrary.authorizationStatus() == .denied {
            DispatchQueue.main.async {
                self.showAuthorizationAlert()
            }
        } else if PHPhotoLibrary.authorizationStatus() == .notDetermined{
            PHPhotoLibrary.requestAuthorization {
                status in
                // 어떤 상태값을 눌렀는지 확인할 수 있다.
                // 물어보는 문구를 적어줘야 하는데,
                // info.plist에서 설정한다.
                // Privacy - Photo Library Usage Description
                // -> 어플 배포 시, 제대로 안 적어주면 심사에서 통과가 안된다.
//                print(status)
                // 다시 한 번 재귀로 물어봐주는 것이 좋다.
                self.checkPermission()
            }
        }
    }
    
    func showAuthorizationAlert() {
        let alert = UIAlertController(title: "갤러리 접근을 허용해주세요.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정열기", style: .default, handler: {
            action in
            
            // 외부의 어떤 특정 주소로 이동가능하게 해준다.
            guard let url = URL(string:UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
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

extension ViewController: PHPickerViewControllerDelegate {
    // 사용자가 Cancel 이든, Add 든, 어떤 버튼을 눌렀을 때, 반응
    // Cancel을 누르면 results 에는 아무것도 들어오지 않는다.
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.dismiss(animated: true, completion: nil)
    }
}
