import Foundation
import RealmSwift

final class CartItemModel: Object, Codable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var userId: String = ""
    @Persisted var quantity: Int = 0
    @Persisted var productId: UUID = UUID()
}
