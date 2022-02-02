import Foundation
import RealmSwift


final class ProductRepo: ObservableObject {
    let db: Realm
    
    
    
    func getById(_ id: UUID) -> ProductModel {
        return db.object(ofType: ProductModel.self, forPrimaryKey: id)!
    }
    
    func getByCategoryId(_ categoryId: UUID) -> [ProductModel] {
        return db.objects(ProductModel.self)
            .where { $0.categoryId == categoryId }
//            .filter("categoryId==\(categoryId.uuidString)")
            .map { $0 }
    }
    
    
    init(realm: Realm) {
        self.db = realm
    }
    
}
