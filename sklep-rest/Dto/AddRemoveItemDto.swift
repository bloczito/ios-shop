import Foundation


struct AddRemoveItemDto: Codable {
    let productId: UUID
    let quantity: Int
}
