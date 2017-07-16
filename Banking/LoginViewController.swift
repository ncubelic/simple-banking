import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Banking"
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let firstName = UserDefaults.standard.string(forKey: "UserFirstName") else {
            showAlert()
            return
        }
        guard let lastName = UserDefaults.standard.string(forKey: "UserLastName") else {
            showAlert()
            return
        }
        
        let user = User(id: 1, firstName: firstName, lastName: lastName)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PinViewController") as! PinViewController
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showRegisterAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Please register first", message: "No user available", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}
