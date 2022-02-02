import RealmSwift

class PersistenceController {
    
    static func initialize() -> Realm {
        do {
            return try Realm()
        } catch let err {
            print("Initializing real DB error: \(err)")
            fatalError("Initializing real DB error: \(err)")
        }
    }
}
