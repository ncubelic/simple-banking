import Foundation

class User {
    
    var id: Int
    var firstName: String
    var lastName: String
    var accounts: [Account]
    
    init(id: Int, firstName: String, lastName: String, accounts: [Account] = []) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.accounts = accounts
    }
    
    func setupWith(_ dict: [String: Any]) {
        
        if let idString = dict["user_id"] as? String {
            id = Int(idString) ?? 0
        }
        
        if let accountsJson = dict["acounts"] as? [[String: Any]] {
            for item in accountsJson {
                let account = Account(id: 0, iban: "", currency: "")
                account.setupWith(item)
                accounts.append(account)
            }
        }
    }
}
