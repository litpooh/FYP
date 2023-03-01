//
//  BarChart.swift
//  DatabaseFetch
//
//  Created by hi on 13/3/2022.
//

import SwiftUI

struct BarChart: View {
    var bars: [Bar]
    var body: some View {
        GeometryReader{ proxy in
            HStack{
                ForEach(bars.indices,id: \.self){index in
                    let bar = bars[index]
                    
                    VStack(spacing: 0){
                        
                        VStack(spacing: 5){
                            
                            AnimatedBarChart(bar: bars[index], index: index)
                        }
                        .padding(.horizontal,5)
                        .frame(height: getBarHeight(point: CGFloat(bar.number), size: proxy.size, max: getMax(bars: bars)))
                        
                        Text(bar.problem)
                            .font(.caption)
                            .frame(height: 25,alignment: .bottom)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        }
        .frame(height: 190)
    }
}

struct AnimatedBarChart: View{
    var bar: Bar
    var index: Int
    
    @State var showBar: Bool = false
    
    var body: some View{
        VStack(spacing: 0){
            Spacer(minLength: 0)
            
            if showBar {
                Text(String(bar.number))
                    .font(.caption)
                    .padding(.bottom, 10.0)
                    .frame(height: 25,alignment: .bottom)
                    
            }
            
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(bar.color)
                .frame(height: showBar ? nil : 0,alignment: .bottom)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8).delay(Double(index) * 0.1)){
                    showBar = true
                }
            }
        }
    }
}

func getBarHeight(point: CGFloat,size: CGSize, max: CGFloat)->CGFloat{
    
    // 25 Text Height
    // 5 Spacing..
    var height = CGFloat(0)
    // avoid dividing by zero
    if max != 0 {
        height = (point / max) * (size.height - 37)
    }
    
    
    return height
}

func getMax(bars: [Bar])->CGFloat{
    let max = bars.max { first, scnd in
        return scnd.number > first.number
    }?.number ?? 0
    
    return CGFloat(max)
}

//struct BarChart_Previews: PreviewProvider {
//    static var previews: some View {
//        BarChart()
//    }
//}
