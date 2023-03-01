//
//  ManageView.swift
//  DatabaseFetch
//
//  Created by hi on 11/3/2022.
//

import SwiftUI
import Firebase

struct ManageView: View {
    var email: String
    
//    @State var show = false
//    @Namespace var namespace
    @State var selectedItem: Feature? = nil
//    @State var isDisabled = false
    
    var body: some View{
        
        NavigationView {
            ScrollView {
                VStack{
                    HStack(alignment: .bottom){
                        Text("Welcome!")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .padding(.top, 35.0)
                        .foregroundColor(Color.black.opacity(0.7))
                        
                        Spacer()
                        
                        Button(action: {
                            try! Auth.auth().signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                            UserDefaults.standard.set("", forKey: "email")
                            NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
                        }) {
                            Text("Log out")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal)
                                .frame(width: 100)
                        }
                        .background(Color("Color"))
                        .cornerRadius(15)
                        .padding(.top, 25)
                    }
                    .padding(.horizontal)
                    
                    FeatureView(feature: manage_features[0])
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 350)
                    
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                        spacing: 16
                    ) {
                        ForEach(manage_features.dropFirst()) { item in
                            FeatureView(feature: item)
                                .frame(height: 200)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .navigationTitle("")
                    .navigationBarHidden(true)
    //                    .navigationBarItems(leading:
    //                                            Text("Welcome!")
    //                                            .font(.system(size: 48))
    //                                            .fontWeight(.bold)
    //                                            .padding(.top, 35.0)
    //                                            .foregroundColor(Color.black.opacity(0.7))
    //                                        , trailing:
    //                                            Button(action: {
    //                                            try! Auth.auth().signOut()
    //                                            UserDefaults.standard.set(false, forKey: "status")
    //                                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
    //                                            UserDefaults.standard.set("", forKey: "email")
    //                                            NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
    //
    //                                        }) {
    //
    //                                            Text("Log out")
    //                                                .font(.system(size: 18))
    //                                                .foregroundColor(.white)
    //                                                .padding(.vertical)
    //                                                .padding(.horizontal)
    //                                                .frame(width: 100)
    //                                        }
    //                                        .background(Color("Color"))
    //                                        .cornerRadius(15)
    //                                        .padding(.top, 25))
                    
    //                Text("Welcome!"+email)
    //                    .font(.title)
    //                    .fontWeight(.bold)
    //                    .foregroundColor(Color.black.opacity(0.7))
    //
    //                Button(action: {
    //
    //                    try! Auth.auth().signOut()
    //                    UserDefaults.standard.set(false, forKey: "status")
    //                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
    //                    UserDefaults.standard.set("", forKey: "email")
    //                    NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
    //
    //                }) {
    //
    //                    Text("Log out")
    //                        .foregroundColor(.white)
    //                        .padding(.vertical)
    //                        .frame(width: UIScreen.main.bounds.width - 50)
    //                }
    //                .background(Color("Color"))
    //                .cornerRadius(10)
    //                .padding(.top, 25)
                }
                
                
            }
        }
    }
}

struct ManageView_Previews: PreviewProvider {
    static var previews: some View {
        ManageView(email: "")
    }
}
