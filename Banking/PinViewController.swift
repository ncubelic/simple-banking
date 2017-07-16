import UIKit

class PinViewController: UIViewController {
    
    @IBOutlet weak var pinTextField: UITextField!

    enum ViewType {
        case register, login
    }
    
    var user: User?
    var registerTitle: String?
    var viewType: ViewType = .login
    
    lazy var keyboardView: PinKeyboard = PinKeyboard.fromNib()

    override func viewDidLoad() {
        super.viewDidLoad()

        pinTextField.inputView = UIView()
        
        guard let user = user else { return }
        navigationItem.title = "\(user.firstName) \(user.lastName)"
        
        if let title = registerTitle {
            navigationItem.title = title
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            
            guard let keyboardView = self?.keyboardView else { return }
            self?.view.addSubview(keyboardView)
            keyboardView.autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleLeftMargin]
            keyboardView.delegate = self
            
            guard let view = self?.view else { return }
            
            self?.keyboardView.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: view.bounds.maxY))
            
            UIView.animate(withDuration: 0.5) {
                self?.keyboardView.transform = CGAffineTransform(translationX: 0, y: view.bounds.maxY - keyboardView.bounds.height)
                self?.pinTextField.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let user = user else { return }
        
        if viewType == .login {
            guard let userPIN = UserDefaults.standard.string(forKey: "UserPIN") else { return }
            guard let enteredPIN = pinTextField.text else { return }
            
            if userPIN == enteredPIN {
                UserDefaults.standard.setValue(user.id, forKey: "LoggedIn")
                dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Wrong PIN", message: "Please try again", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
            }
        } else {
            UserDefaults.standard.setValue(user.id, forKey: "LoggedIn")
            UserDefaults.standard.setValue(user.firstName, forKey: "UserFirstName")
            UserDefaults.standard.setValue(user.lastName, forKey: "UserLastName")
            UserDefaults.standard.setValue(pinTextField.text, forKey: "UserPIN")
            dismiss(animated: true, completion: nil)
        }
    }
    
}

extension PinViewController: PinKeyboardDelegate {
    
    func didPressKey(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else { return }
        
        if let _ = Int(buttonText) {
            pinTextField.text?.append(buttonText)
        } else {
            guard let text = pinTextField.text else { return }
            if !text.isEmpty {   
                let truncated = text.substring(to: text.index(before: text.endIndex))
                pinTextField.text = truncated
            }
        }
    }
}
