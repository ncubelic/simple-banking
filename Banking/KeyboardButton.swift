import UIKit

class KeyboardButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.borderGray.cgColor
        
        if let image = imageView {
            image.contentMode = .center
        }
    }

}
