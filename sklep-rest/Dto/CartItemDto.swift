import Foundation


struct CartItemDto: Codable, Hashable {
    
    let id: UUID
    let product: ProductDto
    var quantity: Int

    static func == (lhs: CartItemDto, rhs: CartItemDto) -> Bool {
        lhs.quantity == rhs.quantity && lhs.product.id == rhs.product.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(quantity)
        hasher.combine(product.id)
    }
    
    
    struct ProductDto: Codable {
        let id: UUID
        let price: Double
        let title: String
        let image: String
        let quantity: Int
    }
    
}
