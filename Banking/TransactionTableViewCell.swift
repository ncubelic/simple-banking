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
        amountLabel.text = String("$ \(transaction.amount)")
        
        if let type = transaction.type {
            switch type {
            case "EXCHANGE":
                typeImageView.image = UIImage(named: "Exchange")
            case "GSM VOUCHER":
                typeImageView.image = UIImage(named: "Gsm-Voucher")
            default:
                typeImageView.image = UIImage(named: "Unknown")
            }
        }
    }

}
