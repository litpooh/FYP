//
//  BarChartView.swift
//  DatabaseFetch
//
//  Created by hi on 13/3/2022.
//

import SwiftUI

struct BarChartView: View {
    var bars: [Bar]
    var body: some View {
        VStack(spacing: 15){
            Text("Reported Problems: ")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            BarChart(bars: bars)
        }
        .padding(.horizontal,20)
        .padding(.vertical,25)
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(bars: bars_demo)
    }
}
