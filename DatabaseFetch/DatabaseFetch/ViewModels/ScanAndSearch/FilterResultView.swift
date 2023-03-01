//
//  NothingView.swift
//  DatabaseFetch
//
//  Created by hi on 2/2/2022.
//

import SwiftUI

struct FilterResultView: View {
    @State var results:Array<CollectionPoint>
    var body: some View {
        List(results, id: \.cp_id) { point in
            VStack (alignment: .leading, spacing: 10){
                Text("Address: "+point.address_en)
                Text("Legend: "+point.legend)
                Text("Accessibility notes: "+point.accessibility_notes)
            }
            .padding(.bottom, 30.0)
            
        }
    }
}

struct FilterResultView_Previews: PreviewProvider {
    static var previews: some View {
        FilterResultView(results: Array<CollectionPoint>())
    }
}
