//
//  ViewPointRatings.swift
//  DatabaseFetch
//
//  Created by hi on 13/3/2022.
//

import SwiftUI

struct ViewPointRatings: View {
    var point: CollectionPoint
    
    var bars: [Bar] {
        return [Bar(problem: "Dirty", number: point.dirty_num), Bar(problem: "Full", number: point.full_num), Bar(problem: "Transport", number: point.transportation_num), Bar(problem: "Wrong", number: point.wrong_num), Bar(problem: "Impolite", number: point.impolite_num)]
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 5) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(point.address_en)
                        .font(.largeTitle)
                    .fontWeight(.bold)
                    Text("ID: "+String(point.cp_id))
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(point.district_id)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                HStack {
                                    ForEach(point.waste_type, id: \.self) { type in
                                        Image(type)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width:30)
                                    }
                                }
                                .padding(.bottom, 50.0)
                }
                .padding(.horizontal,20)
                
                
                VStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Rate Sore")
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 20){
                            Text("\(point.score, specifier: "%.1f")")
                                .font(.system(size: 45, weight: .bold))
                            
                            HStack(spacing: 2) {
                                
                                ForEach(1..<6, id: \.self) { number in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(number > Int(round(point.score)) ? Color.gray : Color.yellow)
                                }
                            }
                            .font(.system(size: 25))
                        }
                        
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,20)
                    .padding(.vertical,25)
                    .background{
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(.ultraThinMaterial)
                    }
                }
                .padding(.bottom, 20)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Reported Problems")
                        .fontWeight(.semibold)
                    
                    BarChart(bars: bars)
                }
                .padding(.horizontal,20)
                .padding(.vertical,25)
                .background{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.ultraThinMaterial)
                }
                
            }
            .padding(.horizontal, 15.0)
        }
        
    }
}

struct ViewPointRatings_Previews: PreviewProvider {
    static var previews: some View {
        ViewPointRatings(point: CollectionPointData().points[0])
    }
}
