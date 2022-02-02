import Foundation


class TokenHandler {
    
    private static let tag = "blok.sklep.uj.pl"
    
    static func loadToken() -> String? {
        let getQuery = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: tag,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?

        SecItemCopyMatching(getQuery, &result)
        
        
        if let dic = result as? NSDictionary {
            if let data = dic[kSecValueData] as? Data {
                if let expirationData = dic[kSecAttrLabel] as? Data {
                    let expirationTime = Double(String(data: expirationData, encoding: .utf8)!)!
                    let expirationDate = Date(timeIntervalSince1970: expirationTime)
                    
                    if Date() >= expirationDate {
                        removeToken()
                    } else {
                        let token = String(data: data, encoding: .utf8)!
                        return token
                    }
                } else {

                }
            }
        }
        removeToken()
        return nil
    }
    
    static func saveToken(_ token: String, expirationDate: Date) {
        let keychainItemQuery = [
            kSecValueData: token.data(using: .utf8)!,
            kSecAttrApplicationTag: tag,
            kSecAttrLabel: String(expirationDate.timeIntervalSince1970).data(using: .utf8)!,
            kSecClass: kSecClassKey
        ] as CFDictionary

        let status = SecItemAdd(keychainItemQuery, nil)
        
    }
    
    static func removeToken() {
        let getQuery = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: tag,
        ] as CFDictionary

        SecItemDelete(getQuery)
    }
}
