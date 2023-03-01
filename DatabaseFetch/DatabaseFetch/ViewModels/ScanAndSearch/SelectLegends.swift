//
//  SelectLegends.swift
//  DatabaseFetch
//
//  Created by hi on 2/2/2022.
//

import SwiftUI

struct SelectLegends: View {
    @EnvironmentObject var selected_legends: SelectedLegends
    
    var body: some View {
        NavigationView{
            List(Types().legends_all, id: \.self, selection: $selected_legends.legends) { legend in
                HStack{
                    GetSafeImage().get(named: legend)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50)
                    Text(legend)
                }
            }
            .navigationTitle("Legends")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct SelectLegends_Previews: PreviewProvider {
    static var previews: some View {
        SelectLegends()
    }
}
