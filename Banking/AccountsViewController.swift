import UIKit

let numberFormatter = NumberFormatter()
let dateFormatter = DateFormatter()

protocol AccountDelegate {
    func showLoginScreen()
}

class AccountsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var delegate: AccountDelegate?
    
    var colors: [UIColor] = [.navigationBarBlue, .green, .purple]
    
    var accounts: [Account] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.init(identifier: "hr")
        dateFormatter.dateFormat = "dd.MM.yyyy."
    
        parseJson()

        // if user login is required only once, but not very secure for banking
//        guard let _ = UserDefaults.standard.string(forKey: "LoggedIn") else {
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            let navVC = UINavigationController(rootViewController: vc)
//            
//            self.present(navVC, animated: true, completion: {
//                blurredEffectView.removeFromSuperview()
//            })
//            
//            return
//        }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navVC = UINavigationController(rootViewController: vc)
        
        self.present(navVC, animated: true, completion: {
            blurredEffectView.removeFromSuperview()
        })
        blurredEffectView.removeFromSuperview()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .actionSheet)
        let actionLogout = UIAlertAction(title: "Logout", style: .destructive, handler: { [weak self] _ in
            UserDefaults.standard.removeObject(forKey: "LoggedIn")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            let navVC = UINavigationController(rootViewController: vc)
            self?.present(navVC, animated: true, completion: nil)
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionLogout)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }

    private func parseJson() {
        
        let bundle = Bundle(for: type(of: self))
        if let theURL = bundle.url(forResource: "Zadatak_1", withExtension: "json") {
            do {
                let data = try Data(contentsOf: theURL)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let user = User(id: 0, firstName: "Nikola", lastName: "Cubelic")
                    user.setupWith(parsedData)
                    accounts = user.accounts
                }
            } catch {
                print(error)
            }
        }
        
    }
}

extension AccountsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = accounts[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionViewCell", for: indexPath) as! AccountCollectionViewCell
        cell.setup(account: item, with: colors[indexPath.row])
        return cell
    }
}

extension AccountsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = accounts[indexPath.row]
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
        vc.account = item
        vc.color = colors[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
