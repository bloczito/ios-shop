import SwiftUI


struct ProductView: View {
    @EnvironmentObject var globalState: GlobalState
//    @EnvironmentObject var productRepo: ProductRepo
    
    var category: CategoryModel
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
         
        VStack {
            if globalState.products.isEmpty {
                Text("Brak dostępnych produktów")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(globalState.products, id: \.self) { product in
                           
                            NavigationLink(destination: ProductDetailsView(product: product)) {
                                ProductIconView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                }
                
            }
        }.onAppear {
            globalState.categoryId = category.id
        }
        

        
    }
}


