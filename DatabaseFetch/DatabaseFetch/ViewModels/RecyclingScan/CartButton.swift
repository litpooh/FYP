//
//  CartButton.swift
//  Recycling
//
//  Created by hi on 14/2/2022.
//

import SwiftUI

struct CartButton: View {
    var numberofItems: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing){
           Image(systemName: "cart")
                .padding(.top,5)
            
            if numberofItems > 0 {
                Text("\(numberofItems)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                    .cornerRadius(50)
            }
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(numberofItems: 1)
    }
}
