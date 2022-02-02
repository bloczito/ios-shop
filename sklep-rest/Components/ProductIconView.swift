//
//  ProductIconView.swift
//  sklep-rest
//
//  Created by Bartosz Krawiec on 08/01/2022.
//

import SwiftUI

struct ProductIconView: View {
    
    var product: ProductModel
    
    var body: some View {

//            NavigationLink(destination: ProductDetailsView(product: product)) {
                VStack{
                    AsyncImage(url: URL(string: product.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                            .frame(minHeight: 150)
                    }
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                    
    //                HStack {
                        VStack {
                            Text(product.title)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(String("\(product.quantity) zł"))
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .frame(alignment: .leading)
    //                }
                
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
//            }


    }
}

struct ProductIconView_Previews: PreviewProvider {
    static var previews: some View {
        
//        let product = ProductModel(
//            id: UUID(),
//            title: "Bluza",
//            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled",
//            image: "https://wixapol.pl/wp-content/uploads/2020/07/BLUZA-2.jpg",
//            quantity: 142,
//            price: 120,
//            categoryId:  UUID()
//        )

        ProductIconView(product: ProductModel())
    }
}
