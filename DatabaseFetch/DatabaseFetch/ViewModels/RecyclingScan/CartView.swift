//
//  CartView.swift
//  Recycling
//
//  Created by hi on 14/2/2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    var types_exist:[String] {
        var types_more_than_zero:[String] = []
        for type in Array(cartManager.total.keys) {
            if cartManager.total[type] != nil {
                if cartManager.total[type]! > 0 {
                    types_more_than_zero.append(type)
                }
            }
            if type.contains("Non Recyclable") {
                if let index = types_more_than_zero.firstIndex(of: "Non Recyclable") {
                    types_more_than_zero.remove(at: index)
                }
            }
        }
        return types_more_than_zero
    }
    // pass value to search function
    var types_string:String {
        return types_exist.joined(separator: ",")
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                if (cartManager.items.count > 0) {
                    ForEach(cartManager.items, id: \.id) { item in
                        ItemRow(item: item)
                    }
                    .padding(.bottom, 30.0)
                    
                    HStack{
                        Text("Total recyclable types: ")
                        Spacer()
                        ForEach(types_exist, id: \.self) { type in
                            Image(type)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30)
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    NavigationLink(destination: MapAndResults2(waste_types: types_exist)){
                        Text("Check out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                        .background(.purple)
                        .cornerRadius(10)
                        .padding(.top, 25)
                    }
                }
                else {
                    Text("No items in the cart")
                }
                Spacer()
                    .frame(height: 88)
            }
            .navigationTitle(Text("My Cart"))
            .padding(.top)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
