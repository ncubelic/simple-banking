import Foundation

class Account {
    
    var id: Int
    var iban: String
    var amount: Decimal
    var currency: String
    var transactions: [Transaction]
    
    init(id: Int, iban: String, amount: Decimal = 0.0, currency: String, transactions: [Transaction] = []) {
        self.id = id
        self.iban = iban
        self.amount = amount
        self.currency = currency
        self.transactions = transactions
    }
    
    func setupWith(_ dict: [String: Any]) {
        
        if let idString = dict["id"] as? String {
            id = Int(idString) ?? 0
        }
        
        iban = dict["IBAN"] as? String ?? ""
        if let amountString = dict["amount"] as? String {
            let amountNumber = numberFormatter.number(from: amountString)
            amount = amountNumber?.decimalValue ?? 0.0
        }
        
        currency = dict["currency"] as? String ?? ""
        
        if let transactionsJson = dict["transactions"] as? [[String: Any]] {
            for item in transactionsJson {
                let transaction = Transaction(id: 0)
                transaction.setupWith(item)
                transactions.append(transaction)
            }
        }
    }
}
