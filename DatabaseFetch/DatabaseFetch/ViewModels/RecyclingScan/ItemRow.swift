//
//  ItemRow.swift
//  Recycling
//
//  Created by hi on 14/2/2022.
//

import SwiftUI

struct ItemRow: View {
    @EnvironmentObject var cartManager: CartManager
    var item:Item
    var body: some View {
        HStack(spacing: 20) {
            Image(uiImage: item.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.type)
                    .bold()
                
                Image(item.type)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:30)
            }
            
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .onTapGesture {
                    cartManager.removeFromCart(item: item)
                }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: Item(id: UUID(), type: "Paper", photo: UIImage(named: "Paper")!))
    }
}
