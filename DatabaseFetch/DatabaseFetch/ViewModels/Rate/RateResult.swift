//
//  RateResult.swift
//  DatabaseFetch
//
//  Created by hi on 12/3/2022.
//

import SwiftUI

struct RateResult: View {
    var cp_id: Int
    var email:String
    var selectedScore:Int = 0
    var selectedProblems = [Problem]()
    @State var response:String = ""
    @EnvironmentObject var showRateView: ShowRateView
    
    var isRated: Bool = false
    
    var body: some View {
        VStack {
            Text(response)
                .onAppear{
                    if isRated == true {
                        print("Update Rate")
                        Database().updateRate(email: email, cp_id: cp_id, selectedScore: selectedScore, selectedProblems: selectedProblems) { (response_update) in
                            self.response = response_update
                        }
                    }
                    else {
                        print("Create Rate")
                        Database().createRate(email: email, cp_id: cp_id, selectedScore: selectedScore, selectedProblems: selectedProblems) { (response_create) in
                            self.response = response_create
                        }
                    }
            }
            Button(action: {

                showRateView.showRate = false

            }) {

                Text("Close")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
            }
            .background(.blue)
            .cornerRadius(10)
            .padding(.top, 25)
        }
        .navigationTitle("Result")
        .navigationBarBackButtonHidden(true)
    }
}

struct RateResult_Previews: PreviewProvider {
    static var previews: some View {
        RateResult(cp_id: 0, email: "")
    }
}
