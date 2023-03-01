//
//  BookmarkResult.swift
//  DatabaseFetch
//
//  Created by hi on 2/4/2022.
//

import SwiftUI

struct BookmarkResult: View {
    var cp_id: Int
    var email:String
    @State var response:String = ""
    @EnvironmentObject var showBookmarkView: ShowBookmarkView
    
    var isBookmarked: Bool = false
    
    var body: some View {
        VStack {
            Text(response)
                .onAppear{
                    if isBookmarked == true {
                        print("Remove Bookmark")
                        Database().deleteBookmark(email: email, cp_id: cp_id) { (response_update) in
                            self.response = response_update
                        }
                    }
                    else {
                        print("Create Bookmark")
                        Database().createBookmark(email: email, cp_id: cp_id) { (response_create) in
                            self.response = response_create
                        }
                    }
            }
            Button(action: {

                showBookmarkView.showBookmark = false

            }) {

                Text("Close")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
            }
            .background(.blue)
            .cornerRadius(10)
            .padding(.top, 25)
            .padding(.horizontal)
        }
        .navigationTitle("Result")
        .navigationBarBackButtonHidden(true)
    }
}

//struct BookmarkResult_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkResult()
//    }
//}
