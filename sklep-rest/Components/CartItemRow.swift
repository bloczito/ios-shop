//
//  CartItemRow.swift
//  sklep-rest
//
//  Created by Bartosz Krawiec on 29/01/2022.
//

import SwiftUI

struct CartItemRow: View {
    
    @State var item: CartItemDto
    let deleteItemFn: (UUID) -> ()
//    let increaseItemFn: (UUID, Int) -> ()
//    let increaseItemFn: (UUID, Int) -> ()
    
    @State var quantity: Int
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.product.image)) { $0.resizable()
            } placeholder: {
                ProgressView()
                    .frame(minHeight: 100)
            }
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 100)
                        

            VStack (alignment: .leading) {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.product.title)
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.bottom, 5)

                        Text(String(format: "%.2f zł", Double(item.quantity) * item.product.price))
                            .font(.subheadline)
                            Spacer()
                    }
                }
                
                HStack(alignment:.bottom) {
//                    QuantityPicker(quantity: $quantity, max: item.product.quantity)
                    Text(String(format: "%d x %.2f zł", item.quantity, item.product.price))
                        .font(.caption2)
                    
                    Spacer()
                    
                    Button(action: {deleteItemFn(item.id)}) {
                        Image(systemName: "trash")
                    }
                    .font(.title2)
                    .tint(.red)
                
                }
            }
            
//            Spacer()

        }
        .frame(maxHeight: 100)
        .padding()
        .border(width: 1, edges: [.bottom], color: Color(white: 0.85))

    }
    
    init(item: CartItemDto, deleteItemFn: @escaping (UUID) -> Void) {
        _item = State(initialValue: item)
        _quantity = State(initialValue: item.quantity)
    
        self.deleteItemFn = deleteItemFn
//        self.increaseItemFn = increaseProductFn
    }
}

//struct CartItemRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CartItemRow(
//            item: CartItemDto(
//                id: UUID(),
//                product: CartItemDto.ProductDto(
//                    id: UUID(),
//                    price: 125,
//                    title: "Koszulka hahah",
//                    image: "https://estilex.pl/7243-large_default/koszulka-t-shirt-meski-moraj-100-bawelna.jpg",
//                    quantity: 15
//                ),
//                quantity: 10
//            ), deleteItemFn: { (asd: UUID) -> Void in
//                print(asd)
//            }
//        )
//    }
//}
