//
//  ScoreView.swift
//  DatabaseFetch
//
//  Created by hi on 13/3/2022.
//

import SwiftUI

struct ScoreSelect: View {
    @Binding var score: Int

    var greyStar: Image?
    var yellowStar = Image(systemName: "star.fill")
    
    func star(number: Int) -> Image {
        if number > score {
            return greyStar == nil ? yellowStar : greyStar!
        } else {
            return yellowStar
        }
    }
    
    var body: some View {
        HStack {
            ForEach(1..<6, id: \.self) { number in
                star(number: number)
                    .foregroundColor(number > score ? Color.gray : Color.yellow)
                    .onTapGesture {
                        score = number
                    }
            }
        }
    }
    
}

struct ScoreSelect_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSelect(score: .constant(4))
    }
}

