import UIKit

let numberFormatter = NumberFormatter()

class AccountsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var accounts: [Account] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.init(identifier: "hr")

        parseJson()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
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
        cell.currencyLabel.text = item.currency
        cell.ibanLabel.text = item.iban
        cell.totalAmountLabel.text = String(describing: item.amount)
        return cell
    }
}

extension AccountsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = accounts[indexPath.row]
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
        vc.account = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
