import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var ibanLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var coloredView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 6.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.borderGray.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func setup(account: Account, with color: UIColor) {
        currencyLabel.text = account.currency
        ibanLabel.text = account.iban
        numberFormatter.numberStyle = .currency
        
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
        
        totalAmountLabel.text = numberFormatter.string(for: account.amount)
        coloredView.backgroundColor = color
    }
    
}
