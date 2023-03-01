//
//  RatePoint.swift
//  DatabaseFetch
//
//  Created by hi on 8/3/2022.
//

import SwiftUI

struct Problem:Identifiable, Equatable, Hashable {
    var id = UUID()
    var problem:String
}

struct RatePoint: View {
    var cp_id: Int
    var email:String = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    //@Binding var new_rate: Bool
    var problems = [Problem(problem: "Dirty"), Problem(problem:"Already full of items"), Problem(problem:"Not convenience to get to there or No transportation"), Problem(problem:"Wrong information"), Problem(problem:"Impolite Staff")]
    
    var scores = [1,2,3,4,5]
    
    @State var selectedRows = [Problem]()
    @State var selectedScore = 5
    @State var previous_rate = Rate()
    @State var isRated = false
    
    @EnvironmentObject var showRateView: ShowRateView
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Score")) {
                    HStack {
                        Text("Select the score")
                        Spacer()
                        ScoreSelect(score: $selectedScore)
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                }
                
                Section(header: Text("Report any problems")){
                    ForEach(problems, id:\.self) { problem in 
                        if selectedRows.contains(problem) {
                            RateRow(problem: problem, selectedProblems: self.$selectedRows, isSelected: true)
                        }
                        else {
                            RateRow(problem: problem, selectedProblems: self.$selectedRows, isSelected: false)
                        }
                    }
                }
                
                NavigationLink(destination: RateResult(cp_id: cp_id, email: email, selectedScore: selectedScore, selectedProblems: selectedRows, isRated: isRated)) {
                    Text("Submit")
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }
            }
            .navigationBarTitle(isRated == true ? Text("Update Rate / Report") : Text("Rate / Report"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close"){
                        print("Close button is clicked")
                        withAnimation{showRateView.showRate = false}
                    }
                }
            }
            //.navigationBarTitle(Text("Selected \(selectedRows.count) rows"))
        }
        .onAppear {
            // Load Rate Status
            Database().checkRated(email: email, cp_id: cp_id) { return_rate in
                previous_rate = return_rate
                print("Returned cp_id: "+String(previous_rate.cp_id))
                if previous_rate.cp_id == cp_id {
                    isRated = true
                    if previous_rate.dirty == 1 {
                        selectedRows.append(problems[0])
                    }
                    if previous_rate.full == 1 {
                        selectedRows.append(problems[1])
                    }
                    if previous_rate.transportation == 1 {
                        selectedRows.append(problems[2])
                    }
                    if previous_rate.wrong == 1 {
                        selectedRows.append(problems[3])
                    }
                    if previous_rate.impolite == 1 {
                        selectedRows.append(problems[4])
                    }
                }
                print("Checked rate status")
                print("Rated: "+String(isRated))
            }
        }
    }
}

struct RatePoint_Previews: PreviewProvider {
    static var previews: some View {
        RatePoint(cp_id: 0)
    }
}
