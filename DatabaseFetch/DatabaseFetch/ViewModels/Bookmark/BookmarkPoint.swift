//
//  BookmarkPoint.swift
//  DatabaseFetch
//
//  Created by hi on 2/4/2022.
//

import SwiftUI

struct BookmarkPoint: View {
    var cp_id: Int
    var email:String = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    @State var previous_bookmark = Bookmark()
    @State var isBookmarked = false
    
    @EnvironmentObject var showBookmarkView: ShowBookmarkView
    
    var body: some View {
        NavigationView{
            VStack{
                if isBookmarked == true {
                    Text("You have add this collection point to Bookmarks, are you sure to remove it?")
                }
                else {
                    Text("You can view this collection point in View Bookmarked Points by clicking OK")
                }
                
                HStack{
                    NavigationLink(destination: BookmarkResult(cp_id: cp_id, email: email, isBookmarked: isBookmarked)) {
                        Text("OK")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width - 120)/2)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation{showBookmarkView.showBookmark = false}
                        
                    }) {
                        
                        Text("Cancel")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width - 120)/2)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
            }
            .navigationBarTitle(isBookmarked == true ? Text("Remove Bookmark") : Text("Bookmark"))
            .padding(.horizontal)
            .onAppear{
                Database().checkBookmarked(email: email, cp_id: cp_id) { return_bookmark in
                    previous_bookmark = return_bookmark
                    if previous_bookmark.cp_id == cp_id {
                        isBookmarked = true
                    }
                }
            }
        }
    }
}

//struct BookmarkPoint_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkPoint()
//    }
//}
