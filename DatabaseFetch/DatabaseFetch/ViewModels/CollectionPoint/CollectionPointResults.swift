//
//  CollectionPointResults.swift
//  Recycling
//
//  Created by hi on 14/1/2022.
//

import SwiftUI

struct CollectionPointResults: View {
    var data = CollectionPointData()
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        List {
            ForEach(data.points, id: \.cp_id) { point in
                NavigationLink(destination: CollectionPointDetails(point: point)){
                    CollectionPointRow(point: point)
                }
            }
        }
        .listStyle(.plain)
//        NavigationView{
//            List {
//                ForEach(data.points, id: \.cp_id) { point in
//                    CollectionPointRow(point: point)
//                }
//            }
//            .listStyle(.plain)
//            .navigationBarTitle("Back to list")
//                        .navigationBarHidden(self.isNavigationBarHidden)
//                        .onAppear {
//                            self.isNavigationBarHidden = true
//                        }
//        }
          
    }
}

struct CollectionPointResults_Previews: PreviewProvider {
    static var previews: some View {
        CollectionPointResults()
    }
}
