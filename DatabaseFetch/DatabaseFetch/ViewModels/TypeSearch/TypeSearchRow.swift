//
//  TypeSearchRow.swift
//  DatabaseFetch
//
//  Created by hi on 1/4/2022.
//

import SwiftUI

struct TypeRow: View {
    var type: String
    @Binding var selectedTypes: [String]
    @State var isSelected:Bool = false
    
//    {
//        for selected_problem in selectedProblems {
//            if problem.problem == selected_problem.problem {
//                return true
//            }
//        }
//        return false
//    }
    
    
    var body: some View {
        HStack{
            GetSafeImage().get(named: type)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:30)
            Text(type)
            Spacer()
            if isSelected{
                Image(systemName: "circle.inset.filled")
                    .foregroundColor(.blue)
                
            }
            
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            self.isSelected.toggle()
            if self.isSelected {
                self.selectedTypes.append(type)
                print("Selected: "+type)
                for selected in selectedTypes {
                    print("All selected: "+selected)
                }
            } else {
                if let index = selectedTypes.firstIndex(of: type) {
                    self.selectedTypes.remove(at: index)
                }
            }
        }
        
    }
}

//struct TypeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TypeRow()
//    }
//}
