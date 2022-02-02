import RealmSwift
import Foundation

class CategoryModel: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var title: String = ""
//    @Persisted var products: List<ProductModel> = 

}
