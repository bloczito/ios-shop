//
//  QuantityPicker.swift
//  sklep-rest
//
//  Created by Bartosz Krawiec on 22/01/2022.
//

import SwiftUI

struct QuantityPicker: View {
    @Binding var quantity: Int
    
    let max: Int
    
    var body: some View {
        HStack() {
            Button(action: increment) {
                Image(systemName: "plus")
                    .font(.system(size: 15, weight: .bold))
            }
            .buttonStyle(.borderedProminent)
            .clipShape(Circle())
            .disabled(!(quantity < max))
            
            Spacer()
            
            Text("\(quantity)")
            
            Spacer()
            
            Button(action: decrement) {
                Image(systemName: "minus")
                    .font(.system(size: 15, weight: .bold))
                    .padding(5)
            }
            .buttonStyle(.borderedProminent)
            .clipShape(Circle())
            .disabled(!(quantity > 1))
        }
        .tint(.black)
        .frame(maxWidth: 130)
        
    }
    
    func increment() {
        if quantity < max {
            quantity += 1
        }
    }
    
    func decrement() {
        if quantity > 1 {
            quantity -= 1
        }
    }

}

struct QuantityPicker_Previews: PreviewProvider {
    @State static var asd = 0
    
    static var previews: some View {
        QuantityPicker(quantity: $asd, max: 10)
    }
}
