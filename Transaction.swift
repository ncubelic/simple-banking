import Foundation

var dateFormatter = DateFormatter()

class Transaction {
    
    var id: Int
    var date: Date
    var description: String
    var amount: Decimal
    var type: String?
    
    init(id: Int, date: Date = Date(), description: String = "", amount: Decimal = 0.0) {
        self.id = id
        self.date = date
        self.description = description
        self.amount = amount
    }
    
    func setupWith(_ dict: [String: Any]) {
        
        // FIXME: move somewhere else
        dateFormatter.dateFormat = "dd.MM.yyyy."
        
        if let idString = dict["id"] as? String {
            id = Int(idString) ?? 0
        }
        if let dateString  = dict["date"] as? String {
            date = dateFormatter.date(from: dateString) ?? Date()
        }
        description = dict["description"] as? String ?? ""
        
        let amountString = dict["amount"] as? String ?? ""
        type = dict["type"] as? String
    }
    
}
