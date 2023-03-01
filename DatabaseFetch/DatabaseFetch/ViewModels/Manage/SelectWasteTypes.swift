//
//  SelectWasteTypes.swift
//  DatabaseFetch
//
//  Created by hi on 31/1/2022.
//

import SwiftUI

struct SelectWasteTypes: View {
    @EnvironmentObject var selected_types: SelectedTypes
    
    var body: some View {
        NavigationView{
            List(Types().waste_types_all, id: \.self, selection: $selected_types.types) { type in
                HStack{
                    GetSafeImage().get(named: type)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50)
                    Text(type)
                }
            }
            .navigationTitle("Recyclables")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct SelectWasteTypes_Previews: PreviewProvider {
    static var previews: some View {
        SelectWasteTypes()
    }
}
