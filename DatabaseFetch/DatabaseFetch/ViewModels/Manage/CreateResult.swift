//
//  Home.swift
//  DatabaseFetch
//
//  Created by hi on 1/2/2022.
//

import SwiftUI

struct CreateResult: View {
    var email:String = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    var new_point:CollectionPoint
    @State var response_create = ""
    var body: some View {
        VStack {
            Text("Result of Creating Point: "+ListFormatter.localizedString(byJoining: new_point.waste_type))
                .padding(.bottom, 30.0)
            Text(response_create)
                .onAppear{
                    Database().createPost(email: email, new_point: new_point) { (response_create) in
                        self.response_create = response_create
                    }
                }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

struct CreateResult_Previews: PreviewProvider {
    static var previews: some View {
        CreateResult(new_point: CollectionPointData.init().points[0])
    }
}
