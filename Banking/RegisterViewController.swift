import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func nextAction(_ sender: Any) {
        
        guard let firstname = firstNameTextField.text, !firstname.isEmpty else {
            showAlert(title: "First name is mandatory field", message: "Please try again")
            return
        }
        
        if firstname.characters.count > 30 {
           showAlert(title: "Validation Error", message: "Please enter up to 30 alphanumeric characters")
        }
        
        guard let lastname = lastnameTextField.text, !lastname.isEmpty else {
            showAlert(title: "Last name is mandatory field", message: "Please try again")
            return
        }
        
        if lastname.characters.count > 30 {
            showAlert(title: "Validation Error", message: "Please enter up to 30 alphanumeric characters")
        }
        
        
        let user = User(id: 1, firstName: firstname, lastName: lastname)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PinViewController") as! PinViewController
        vc.user = user
        vc.registerTitle = "Step II"
        vc.viewType = .register
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let validChars = NSCharacterSet.alphanumerics.inverted
        
        let range = string.rangeOfCharacter(from: validChars)
        
        if range != nil {
            return false
        } else {
            return true
        }
    }
}
