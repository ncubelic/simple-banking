import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(transaction: Transaction) {
        descriptionLabel.text = transaction.description
        dateLabel.text = dateFormatter.string(from: transaction.date)
        
        
        switch transaction.currency {
        case .hrk:
            numberFormatter.locale = Locale.init(identifier: "hr")
            numberFormatter.currencySymbol = "Kn"
        case .eur:
            numberFormatter.locale = Locale.init(identifier: "de")
            numberFormatter.currencySymbol = "€"
        case .usd:
            numberFormatter.locale = Locale.init(identifier: "en")
            numberFormatter.currencySymbol = "$"
        case .none:
            numberFormatter.locale = Locale.init(identifier: "hr")
            numberFormatter.currencySymbol = "Kn"
        }
        amountLabel.text = numberFormatter.string(for: transaction.amount)
        
        if let type = transaction.type {
            switch type {
            case "EXCHANGE":
                typeImageView.image = UIImage(named: "Exchange")
            case "GSM VOUCHER":
                typeImageView.image = UIImage(named: "Gsm")
            default:
                typeImageView.image = UIImage(named: "Unknown")
            }
        } else {
            typeImageView.image = UIImage(named: "Unknown")
        }
    }

}
