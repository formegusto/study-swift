import Foundation
import UIKit
import PhotosUI

class PhotoCell : UICollectionViewCell {
    func loadCell(asset: PHAsset) {
        let imageManager = PHImageManager()
        
        // 아이폰은 해상도 별로 표시할 수 있는 픽셀수가 다르기 때문에
        // 이를 가지고 와서 곱해줘야 한다.
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 300 * scale, height: 300 * scale)
        
        // 저화질 혹은 고화질로만 받고싶은 경우,
        // 아래와 같이 옵션을 설정해서 requestImage 하면 된다.
        let options = PHImageRequestOptions()
//        options.deliveryMode = .fastFormat // 저화질
//        options.deliveryMode = .highQualityFormat // 고화질
        options.deliveryMode = .opportunistic // 두개 다
        
        // 초기에 고화질로 가져오는 경우, 지연이 있어서
        // 순서가 바뀌는 것처럼 보이기 때문에 한번 비워준다.
        self.photoImageView.image = nil
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options) { image, info in
            // 이제 이미지로 변환된 것이 여기에 담김.
            // 하나의 사진을 가지고 오면, 저화질 고화질 한번씩 해서 총 2번 가지고오게 됨.
//                self.images.append(image)
            // 위 말고, 이렇게 구성하면, photoImageView에 저화질 한 번, 고화질 한 번, 이런식으로 들어가게 됨.
            // info structure
            /*
             (lldb) po info
             ▿ Optional<Dictionary<AnyHashable, Any>>
               ▿ some : 2 elements
                 ▿ 0 : 2 elements
                   ▿ key : AnyHashable("PHImageResultIsDegradedKey")
                     - value : "PHImageResultIsDegradedKey" -> False면 고화질, True면 저화질
                   - value : 1
                 ▿ 1 : 2 elements
                   ▿ key : AnyHashable("PHImageResultRequestIDKey")
                     - value : "PHImageResultRequestIDKey"
                   - value : 1
             */
            if (info?[PHImageResultIsDegradedKey ] as? Bool) == true {
                // 저화질
                self.photoImageView.image = image
            } else {
                // 고화질
            }
//            self.photoImageView.image = image
        }
    }
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            // imageView Contents 설정
            photoImageView.contentMode = .scaleAspectFill
        }
    }
}
