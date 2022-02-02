import RealmSwift
import Foundation


class ProductModel: Object, Codable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var title: String = ""
    @Persisted var desc: String? = nil
    @Persisted var image: String = ""
    @Persisted var quantity: Int = 0
    @Persisted var price: Double = 0.0
    @Persisted var categoryId: UUID = UUID()
    
    
    
//    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
//        return lhs.id == rhs.id &&
//        lhs.title == rhs.title &&
//        lhs.description == rhs.description &&
//        lhs.image == rhs.image &&
//        lhs.quantity == rhs.quantity &&
//        lhs.price == rhs.price &&
//        lhs.categoryId == rhs.categoryId
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(self.id)
//    }

  
    
//    init(id: UUID, title: String, description: String?, image: String, quantity: Int, price: Double, categoryId: UUID) {
//        self.id = id
//        self.title = title
//        self.desc = description
//        self.image = image
//        self.quantity = quantity
//        self.price = price
//        self.categoryId = categoryId
//    }
    
    
}
