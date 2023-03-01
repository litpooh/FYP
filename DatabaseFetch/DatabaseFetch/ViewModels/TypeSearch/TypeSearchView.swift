//
//  TypeSearchView.swift
//  DatabaseFetch
//
//  Created by hi on 1/4/2022.
//

import SwiftUI

struct TypeSearchView: View {
    var types = Types().waste_types_all
    @State var selectedTypes = [String]()
    
    var body: some View {
        Form{
            Section{
                ForEach(types, id:\.self) { type in
                    if selectedTypes.contains(type) {
                        TypeRow(type: type, selectedTypes: self.$selectedTypes, isSelected: true)
                    }
                    else {
                        TypeRow(type: type, selectedTypes: self.$selectedTypes, isSelected: false)
                    }
                }
            }
            
            Section {
                NavigationLink(destination: TypeSearchResult(waste_types: selectedTypes)) {
                    Text("Submit")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 30)
            
        //.navigationBarTitle(Text("Selected \(selectedRows.count) rows"))
        }
        .navigationBarTitle("Select Types")
    }
}

struct TypeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TypeSearchView()
    }
}
