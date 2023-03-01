//
//  CollectionPointRow.swift
//  Recycling
//
//  Created by hi on 13/1/2022.
//

import SwiftUI

struct CollectionPointRow: View {
    
    var point:CollectionPoint
    
    var body: some View {
        HStack {
            GetSafeImage().get(named: point.legend)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:70)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(point.address_en)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.headline)
                Text(point.district_id)
                    .foregroundColor(.gray)
                    .bold()
                
                if (point.waste_type.count > 0){
                    if (point.waste_type.count < 5) {
                        HStack {
                            ForEach(point.waste_type, id: \.self) { type in
                                getSafeImage(named: type)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:30)
                            }
                        }
                    }
                    if (point.waste_type.count > 4 && point.waste_type.count < 9) {
                        VStack(alignment: .leading, spacing: 2) {
                            // first 4
                            HStack {
                                ForEach(0..<4, id: \.self) { i in
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                            // last n-4
                            HStack {
                                ForEach(4..<point.waste_type.count, id: \.self) { i in
                                    // i = 7: Out of range (idk why)
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                        }
                    }
                    if (point.waste_type.count > 8 && point.waste_type.count < 13) {
                        VStack(alignment: .leading, spacing: 2) {
                            // first 4
                            HStack {
                                ForEach(0..<4, id: \.self) { i in
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                            // next 5-8
                            HStack {
                                ForEach(4..<8, id: \.self) { i in
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                            // last n-8
                            HStack {
                                ForEach(8..<point.waste_type.count, id: \.self) { i in
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                        }
                    }
                    if (point.waste_type.count > 12 && point.waste_type.count < 17) {
                        VStack(alignment: .leading, spacing: 2) {
                            // first 4
                            HStack {
                                ForEach(0..<4, id: \.self) { i in
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                            // next 5-8
                            HStack {
                                ForEach(4..<8, id: \.self) { i in
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                            // next 9-12
                            HStack {
                                ForEach(8..<12, id: \.self) { i in
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                            // last n-12
                            HStack {
                                ForEach(12..<point.waste_type.count, id: \.self) { i in
                                    getSafeImage(named: point.waste_type[i])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30)
                                }
                            }
                        }
                    }
                }
                
                        
                    
                
            }
            
            Spacer()
            
            VStack (spacing: 5) {
                Text(String(Int(point.distance))+" M")
                    .bold()
                    .foregroundColor(.purple)
                    .font(.system(size: 25))
                
                
//                ZStack {
//                    Button(action: {
//                       // TESTING
//                       print("clicked")
//                       print(point.waste_type)
//                    }) {
//                       Text("Details")
//                                            .foregroundColor(.white)
//                                            .fontWeight(.bold)
//                                            .font(.system(size: 15))
//                                            .padding(.vertical, 8)
//                                            .padding(.horizontal, 20)
//                                            .background(Color.purple)
//                                            .clipShape(Capsule())
//                    }
//                    NavigationLink(destination: CollectionPointDetails(point: point)){
//                       EmptyView()
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                }

                
                Button(action: {
                    // TESTING
                    print("clicked")
                    //print(point.waste_type)
                    //print(point.address_en+"\n")
                    //print(point.accessibility_notes+"\n")
                }) {

//                    Text("Details")
//                        .foregroundColor(.white)
//                        .fontWeight(.bold)
//                        .font(.system(size: 15))
//                        .padding(.vertical, 8)
//                        .padding(.horizontal, 20)
//                        .background(Color.purple)
//                        .clipShape(Capsule())
//                    HStack {
//                        Text("\(point.score, specifier: "%.1f")")
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                            .font(.system(size: 15))
//                        Text("\(point.score, specifier: "%.1f")")
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                            .font(.system(size: 15))
//                        HStack(spacing: 2) {
//                            ForEach(1..<6, id: \.self) { number in
//                                Image(systemName: "star.fill")
//                                    .foregroundColor(number > Int(round(point.score)) ? Color.gray : Color.yellow)
//                            }
//                        }
//
//                    }
                    HStack(spacing: 2) {
                        
                        ForEach(1..<6, id: \.self) { number in
                            Image(systemName: "star.fill")
                                .foregroundColor(number > Int(round(point.score)) ? Color.gray : Color.yellow)
                        }
                    }
                    .font(.system(size: 10))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.purple)
                    .clipShape(Capsule())
                }
            
            }
        }
        .padding(.horizontal, 5.0)
        .padding(.vertical, 5.0)
        // may add a horizontal padding if needed?
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
        
    }
}

struct CollectionPointRow_Previews: PreviewProvider {
    static var previews: some View {
        CollectionPointRow(point: CollectionPointData().points[3])
    }
}

func getSafeImage(named: String) -> Image {
    var local_named: String = named
    if named.contains("Recycling Stations"){
        local_named = "Recycling Stations"
    }
    else {
        local_named = named
    }
    
   let uiImage =  (UIImage(named: local_named) ?? UIImage(named: "Placeholder"))!
   return Image(uiImage: uiImage)
}

struct DetailsButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            //.font(.bold)
            .font(.system(size: 15))
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(Color.purple)
            .clipShape(Capsule())
//            .scaleEffect(configuration.isPressed ? 1.2 : 1)
//            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
}

