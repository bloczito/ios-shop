import SwiftUI
import RealmSwift

struct ProductDetailsView: View {
    
    typealias ReloadFn = () -> ()
    
    @EnvironmentObject var globalState: GlobalState
    
    let product: ProductModel
    
    @State var quantity: Int
    
    @State var showAlert = false
    
    let reloadCart: ReloadFn?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: product.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                            .frame(minHeight: 150)
                    }
                    .aspectRatio(contentMode: .fit)
                    
                    VStack {
                        HStack {
                            Text(product.title)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text(String(format: "%.2f zł", product.price))
                                .font(.body)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(alignment: .top) {
                            
                            QuantityPicker(quantity: $quantity, max: product.quantity)
                            
                            Spacer()
                            
                            VStack {
                                Button(action: handleAddItem) {
                                    Label("Do koszyka", systemImage: "plus")
                                }
                                .tint(.black)
                                .disabled(!(product.quantity > 0))
                                .buttonStyle(.borderedProminent)
                                .controlSize(.small)
                                
                                
                                if !(product.quantity > 0) {
                                    Text("Wyprzedane")
                                        .font(.caption2)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(product.desc ?? "")
                    }
                    .padding()

                    
                }

            }
            
            if showAlert {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(white: 0.85, opacity: 0.7))
                    .frame(width: 200, height: 100)
                    .overlay {
                        HStack {
                            Image(systemName: "checkmark.circle")
                            
                            Text ("Dodano")
                        }
                        .font(.title)
                        
                    }
                    .shadow(radius: 10)
            }
        }
    }
    
    func handleAddItem() {
//        globalState.setSuccessMsg(msg: "Dodano do koszyka")
        
        let dto = AddRemoveItemDto(productId: product.id, quantity: quantity)
        
        CartApi.addCartItem(token: self.globalState.authToken!, data: dto) { result in
            switch result {
            case .success(let number):
                self.globalState.itemsNumber = number
                self.showAlert = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlert = false
                }
                
                if let reloadCart = reloadCart {
                    reloadCart()
                } else {
                    globalState.reloadCart = true
                }
                
            case .failure(let err):
                self.globalState.setErrorMsg(msg: err.message)
            }
        }
        
        
        
    }
    
    
    init(product: ProductModel, reloadCart: ReloadFn? = nil) {
        self.product = product
        self.quantity = product.quantity > 0 ? 1 : 0
        self.reloadCart = reloadCart
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static func getProduct() -> ProductModel {
        let product = ProductModel()
        
        product.id = UUID()
        product.title = "Bluza"
        product.desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled"
        product.image = "https://wixapol.pl/wp-content/uploads/2020/07/BLUZA-2.jpg"
        product.quantity = 12
        product.price = 120
        product.categoryId = UUID()
        
        return product
    }
    
    static var previews: some View {
        
        
        
        ProductDetailsView(product: getProduct())
    }
}
