import Foundation
import RealmSwift

final class ShopModel: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var address: String = ""
    @Persisted var latitude: Double = 0
    @Persisted var longtitude: Double = 0
}
