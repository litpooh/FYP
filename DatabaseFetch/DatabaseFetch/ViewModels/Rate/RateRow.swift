//
//  RateRow.swift
//  DatabaseFetch
//
//  Created by hi on 8/3/2022.
//

import SwiftUI

struct RateRow: View {
    var problem: Problem
    @Binding var selectedProblems: [Problem]
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
            GetSafeImage().get(named: problem.problem)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:30)
            Text(problem.problem)
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
                self.selectedProblems.append(problem)
                print("Selected: "+problem.problem)
                for selected in selectedProblems {
                    print("All selected: "+selected.problem)
                }
            } else {
                if let index = selectedProblems.firstIndex(of: problem) {
                    self.selectedProblems.remove(at: index)
                }
            }
        }
        
    }
}

//struct ScoreRow : View{
//    var score: Int
//    @Binding var selectedScore: Int
//    @State var isSelected:Bool = false
//
//    var body : some View {
//        HStack{
//            Text(String(score))
//            Spacer()
//            if isSelected{
//                Image(systemName: "circle.inset.filled")
//            }
//
//        }
//        .padding()
//        .contentShape(Rectangle())
//        .onTapGesture {
//            self.isSelected.toggle()
//            if self.isSelected {
//                self.selectedScore = score
//                print("Selected: "+String(score))
//            } else {
//                if let index = selectedProblems.firstIndex(of: problem) {
//                    self.selectedProblems.remove(at: index)
//                }
//            }
//        }
//    }
//}

//struct RateRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RateRow()
//    }
//}
