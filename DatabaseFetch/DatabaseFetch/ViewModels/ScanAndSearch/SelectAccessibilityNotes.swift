//
//  SelectAccessibilityNotes.swift
//  DatabaseFetch
//
//  Created by hi on 2/2/2022.
//

import SwiftUI

struct SelectAccessibilityNotes: View {
    @EnvironmentObject var selected_accessibility_notes: SelectedAccessibilityNotes
    var body: some View {
        NavigationView{
            List(Types().accessibility_notes_all, id: \.self, selection: $selected_accessibility_notes.accessibility_notes) { accessibility_note in
                HStack{
                    GetSafeImage().get(named: accessibility_note)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50)
                    Text(accessibility_note)
                }
            }
            .navigationTitle("Accessibility Notes")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct SelectAccessibilityNotes_Previews: PreviewProvider {
    static var previews: some View {
        SelectAccessibilityNotes()
    }
}
