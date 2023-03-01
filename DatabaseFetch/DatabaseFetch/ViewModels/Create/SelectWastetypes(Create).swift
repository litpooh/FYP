//
//  SelectWastetypes(Create).swift
//  DatabaseFetch
//
//  Created by hi on 7/3/2022.
//

import SwiftUI

struct SelectWastetypes_Create: View {
    @EnvironmentObject var selected_types: SelectedTypes_CreatePoint
    
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

struct SelectWastetypes_Create_Previews: PreviewProvider {
    static var previews: some View {
        SelectWastetypes_Create()
    }
}
