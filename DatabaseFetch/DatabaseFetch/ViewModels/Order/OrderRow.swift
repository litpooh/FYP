//
//  OrderRow.swift
//  DatabaseFetch
//
//  Created by hi on 29/3/2022.
//

import SwiftUI

struct OrderRow: View {
    var order: String
    @Binding var selectedOrder: String
    
    var body: some View {
        HStack{
            GetSafeImage().get(named: order)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:30)
            Text(order)
            Spacer()
            if order == selectedOrder{
                Image(systemName: "circle.inset.filled")
                    .foregroundColor(.blue)
                
            }
            
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            selectedOrder = order
            print("Selected: "+order)
        }
    }
}

//struct OrderRow_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderRow()
//    }
//}
