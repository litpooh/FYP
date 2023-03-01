//
//  Feature.swift
//  DatabaseFetch
//
//  Created by hi on 10/3/2022.
//

import SwiftUI

struct FeatureView: View {
    var feature: Feature = login_features[0]
    
    var body: some View {
        NavigationLink(destination: feature.destination) {
            VStack(alignment: .leading, spacing: 4.0) {
                Spacer()
                HStack {
                    Spacer()
                    Image(feature.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                Text(feature.title).fontWeight(.bold).foregroundColor(Color.white)
                //Text(feature.subtitle).font(.footnote).foregroundColor(Color.white)
            }
            .padding(.all)
            .background(feature.color)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: feature.color.opacity(0.3), radius: 20, x: 0, y: 10)
        }
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView()
    }
}
