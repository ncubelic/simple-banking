import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func nextAction(_ sender: Any) {
        
        if let firstname = firstNameTextField.text {
            if let lastname = lastnameTextField.text {
                let user = User(id: 1, firstName: firstname, lastName: lastname)
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PinViewController") as! PinViewController
                vc.user = user
                vc.registerTitle = "Step II"
                vc.viewType = .register
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
