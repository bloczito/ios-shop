import RealmSwift

final class CategoryRepo: ObservableObject {
    let db: Realm
    
    init(realm: Realm) {
        self.db = realm
    }
    
    
    func getById(id: String) -> CategoryModel {
        return db.object(ofType: CategoryModel.self, forPrimaryKey: id)!
    }
    
    func getAll() -> [CategoryModel] {
        let objs = db.objects(CategoryModel.self)
        return Array(objs)
    }
}
