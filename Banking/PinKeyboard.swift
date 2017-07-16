import UIKit

protocol PinKeyboardDelegate {
    func didPressKey(_ sender: UIButton)
}

class PinKeyboard: UIView {
    
    var delegate: PinKeyboardDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        self.delegate?.didPressKey(sender)
    }
}
