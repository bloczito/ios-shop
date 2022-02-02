import RealmSwift


final class ShopRepo: ObservableObject {
    let db: Realm
    
    func getById(_ id: UUID) -> ShopModel {
        return db.object(ofType: ShopModel.self, forPrimaryKey: id)!
    }
    
    func getAll() -> [ShopModel] {
        return Array(db.objects(ShopModel.self))
    }
    
    
    init(realm: Realm) {
        self.db = realm
    }
    
}
