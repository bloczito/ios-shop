import SwiftUI

struct CartView: View {
    @EnvironmentObject var globalState: GlobalState
    
    @State var products: [CartItemDto] = []
    
//    @State var productRepo: ProductModel {
//        return ProductRepo(realm: globalState.db)
//    }
    
    var body: some View {
        NavigationView {
            
            if globalState.reloadCart && products.count == 0 {
                ProgressView()
            } else {
                if products.count != 0 {
                    ScrollView {
                        ForEach(products, id: \.self) { item in
                            NavigationLink(
                                destination: ProductDetailsView(
                                    product: globalState.productRepo.getById(item.product.id),
                                    reloadCart: self.reloadCart
                                )
                            ){
                                CartItemRow(
                                    item: item,
                                    deleteItemFn: self.handleDeleteItem
        //                            increaseProductFn: increaseItem
                                )
                            }

                        }
                    }
                    .navigationTitle("Koszyk")
                } else {
                    Text("Koszyk jest pusty")
                        .font(.system(size: 30))
                }
                
            }
        }.onAppear {
            if globalState.reloadCart {
                reloadCart()
                globalState.reloadCart = false
            }
        }
    }
    
    func reloadCart() {
        print("hahahahhahaha")
        CartApi.getCartItems(userToken: globalState.authToken!) { result in
            switch result {
            case .failure(let error):
                globalState.setErrorMsg(msg: error.message)
            case .success(let items):
                products = items
            }
        }
    }
    
    func increaseItem(productId: UUID, quantity: Int) {
        let dto = AddRemoveItemDto(productId: productId, quantity: quantity)
        CartApi.addCartItem(token: globalState.authToken!, data: dto) { result in
            switch result {
            case .success(_):
                print()
            case .failure(let error):
                globalState.setErrorMsg(msg: error.message)
            }
        }
    }
    
    
    func handleDeleteItem(itemId: UUID) {
        CartApi.deleteCartItem(
            token: globalState.authToken!,
            productId: itemId) { result in
                switch result {
                case .success():
                    products = products.filter{ item in
                        item.id != itemId
                    }
                    
                    globalState.itemsNumber = products.count
                case .failure(let error):
                    globalState.setErrorMsg(msg: error.message)
                }
            
            }
    }
        
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
