import UIKit

class TransactionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountCurrencyLabel: UILabel!
    @IBOutlet weak var accountIBANLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    @IBOutlet weak var coloredView: UIView!
    
    var transactions: [Transaction] = []
    var account: Account?
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let account = account,
            let color = color
            else { return }
        transactions = account.transactions
        
        navigationItem.title = account.currency
        accountCurrencyLabel.text = account.currency
        accountIBANLabel.text = account.iban
        
        navigationController?.navigationBar.barTintColor = color
        coloredView.backgroundColor = color
        
        switch account.currency {
        case "HRK":
            numberFormatter.locale = Locale.init(identifier: "hr")
            numberFormatter.currencySymbol = "Kn"
        case "EUR":
            numberFormatter.locale = Locale.init(identifier: "de")
            numberFormatter.currencySymbol = "€"
        case "USD":
            numberFormatter.locale = Locale.init(identifier: "en")
            numberFormatter.currencySymbol = "$"
        default:
            numberFormatter.locale = Locale.init(identifier: "hr")
            numberFormatter.currencySymbol = "Kn"
        }
        accountBalanceLabel.text = numberFormatter.string(for: account.amount)
        
        transactions = transactions.sorted(by: { (one, two) in
            return one.date > two.date
        })

        tableView.tableFooterView = UIView()
    }
}

extension TransactionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = transactions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        cell.setup(transaction: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Transactions"
    }
}
