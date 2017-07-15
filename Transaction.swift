import Foundation

enum Currency {
    case hrk, eur, usd, none
}

class Transaction {
    
    var id: Int
    var date: Date
    var description: String
    var amount: Decimal
    var type: String?
    var currency: Currency = .hrk
    
    
    init(id: Int, date: Date = Date(), description: String = "", amount: Decimal = 0.0) {
        self.id = id
        self.date = date
        self.description = description
        self.amount = amount
    }
    
    func setupWith(_ dict: [String: Any]) {
        
        if let idString = dict["id"] as? String {
            id = Int(idString) ?? 0
        }
        if let dateString  = dict["date"] as? String {
            date = dateFormatter.date(from: dateString) ?? Date()
        }
        description = dict["description"] as? String ?? ""
        
        if let amountString = dict["amount"] as? String {
            let number = amountString.components(separatedBy: " ")
            let decimalNumber = number[0]
            
            switch number[1] {
            case "HRK": currency = .hrk
            case "EUR": currency = .eur
            case "USD": currency = .usd
            default: currency = .none
            }
            
            let amountNumber = numberFormatter.number(from: decimalNumber)
            amount = amountNumber?.decimalValue ?? 0.0
        }
        
        type = dict["type"] as? String
    }
    
}
