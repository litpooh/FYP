//
//  UpdateResult.swift
//  DatabaseFetch
//
//  Created by hi on 7/3/2022.
//

import SwiftUI

struct UpdateResult: View {
    var new_point:CollectionPoint
    @State var response_update = ""
    var body: some View {
        VStack {
            Text("Result of Updating Point: "+ListFormatter.localizedString(byJoining: new_point.waste_type))
                .padding(.bottom, 30.0)
            Text(response_update)
                .onAppear{
                    Database().updatePost(new_point: new_point) { (response_update) in
                        self.response_update = response_update
                    }
                }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

struct UpdateResult_Previews: PreviewProvider {
    static var previews: some View {
        UpdateResult(new_point: CollectionPointData.init().points[0])
    }
}
