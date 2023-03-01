//
//  ContentView.swift
//

import SwiftUI

// original-> _copy
// now -> _onlyLabelling
// changed names: 7 -> 6 are decalrations, 1 is function used in scan view
struct ScanView_onlyLabelling: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showingResult: Bool = false
    
    @State private var result: [String:Double] = [String:Double]()
    @State private var stringResult:String = ""
    @State private var image: UIImage? = UIImage(named: "Placeholder")
    @State var itemsStored: [String] = []
    
    @StateObject var cartManager = CartManager()
    
    
    var body: some View {
        
        ZStack {
            VStack {
                
                VStack {
                    
                    Image("Reminder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 10.0)
                        .padding(.horizontal, 12.0)
                        
                        
                    
                    Image(uiImage: image ?? UIImage(named: "Placeholder")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 15.0)
                        .padding(.horizontal, 12.0)
                        
                    
                    
                    Button("Choose Picture") {
                        self.showSheet = true
                    }.padding(.bottom, 50.0)
                        .actionSheet(isPresented: $showSheet) {
                            ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                .default(Text("Photo Library")) {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                },
                                .default(Text("Camera")) {
                                    self.showImagePicker = true
                                    self.sourceType = .camera
                                },
                                .cancel()
                            ])
                    }
                    
                    
                    HStack(spacing: 10) {
                        NavigationLink(destination: CartView().environmentObject(cartManager)) {
                            Text("Finished Scanning")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.purple)
                                .clipShape(Capsule())
                        }
                        
                        Button (action:{
                            self.showingResult = true
    //                        for (key,value) in result{
    //                            stringResult += (key + ": " + String(value) + "\n" )
    //                        }
    //                        print("Result before clear: "+stringResult+"\n")
    //
    //                        result.removeAll()
    //                        stringResult = ""
    //                        print("Result before checking: "+stringResult+"\n")
    //
    //                        let group = DispatchGroup()
    //                        group.enter()
    //                        DispatchQueue.main.async {
    //                            result = ImageLabelling(pickedImage: self.$image, result: self.$result).CollectLabels()
    //                            sleep(5)
    //                            group.leave()
    //                        }
    //
    //                        group.notify(queue: .main) {
    //                            for (key,value) in result{
    //                                stringResult += (key + ": " + String(value) + "\n" )
    //                                print(stringResult)
    //                            }
    //                            print("Result after checking: "+stringResult+"\n")
    //                            self.showingResult = true
    //                        }
                        }) {
                            
                            Text("Check!")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.purple)
                                .clipShape(Capsule())
                        }
                    }
                    
                    //
                    //.alert(isPresented: $showingResult) {
                    //    return Alert(title: Text("Results:"), message: Text(stringResult), dismissButton: .default(Text("Got it!")))
                    //}
                    
                }
                    
                    
                .navigationBarTitle("Check Recyclable")
                .toolbar{
                    NavigationLink{
                        CartView().environmentObject(cartManager)
                    } label: {
                        CartButton(numberofItems: cartManager.items.count)
                    }
                }
                
            }.sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                    .ignoresSafeArea()
            }
            
            if showingResult {
                GeometryReader{ proxy in
                    
                    Color.primary
                        .opacity(0.15)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    CheckResult_onlyLabelling(show: $showingResult, photo: $image)
                    .frame(width: size.width - 40, height: size.height/1.5, alignment: .center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                //Debug_View(show: $showingResult, input_image: $image)
            }
            
        }
        .environmentObject(cartManager)
        .padding(.bottom, 88)
        
        
    }
}

struct ScanView_onlyLabelling_Previews: PreviewProvider {
    static var previews: some View {
        ScanView_onlyLabelling()
    }
}

struct BlurView_onlyLabelling: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct CheckResult_onlyLabelling: View {
    @Binding var show: Bool
    @Binding var photo: UIImage?
    @EnvironmentObject var cartManager: CartManager
    
    let imagelabeller = ImageLabelling()
    @State var label_results_returned = [String: Double]()
    var labels:[String] {
        return Array(label_results_returned.keys)
    }
    
    @State var result_category:Category = Category(name: "loading", collection_image: "loading", recyclables: [])
    
    var body: some View{
        
        NavigationView{
            VStack {
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation{
                            
                            show.toggle()
                        }
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.purple)
                    }
                    .padding()
                }
                
                VStack(spacing: 25){
                    HStack(spacing:10) {
                        Image(result_category.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image("Arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(result_category.collection_image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    
                    
                    Text("Recognized!")
                        .font(.title)
                        .foregroundColor(.pink)
                    
                    Text("It's "+result_category.name)
                    
                    Text(result_category.reminder)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing:10) {
                        Button(action: {
                            withAnimation{
                                
                                show.toggle()
                            }
                        }) {
                            
                            Text("OK!")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.purple)
                                .clipShape(Capsule())
                        }
                        
                        
                    }
                    
                    
                }
                .padding(.vertical, 25)
                .padding(.horizontal, 15)
                .background(.white)
                .cornerRadius(25)
                
                
            }
            .navigationBarHidden(true)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(
//                Color.primary.opacity(0.35)
//            )
        }
        .onAppear{
            let binaryImageData = imagelabeller.base64EncodeImage(photo!)
            let request = imagelabeller.createRequest(with: binaryImageData)
            if (request.httpBody != nil) {
                imagelabeller.runRequestOnBackgroundThread(request) { result in
                    self.label_results_returned = result
                    
                    // put inside upper completion handler may be better?
                    categorize(label_results: label_results_returned) { return_category in
                        self.result_category = return_category
                        
                        //testing addcart function for non recyclable: check success
                        //self.result_category.name = "Non recyclable"
                        if (photo != nil) && (result_category.name.contains("Non Recyclable") == false) {
                            cartManager.addToCart(item: Item(id: UUID(), type: result_category.name, photo: photo!))
                        }
                    }
                }
            }
            
            
        }
        .ignoresSafeArea()
            
    }
        
        
}

struct Debug_View_onlyLabelling : View{
    @Binding var show: Bool
    @Binding var input_image: UIImage?
    let imagelabeller = ImageLabelling()
    @State var label_results_returned = [String: Double]()
    var labels:[String] {
        return Array(label_results_returned.keys)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(labels, id: \.self) { label in
                        if label_results_returned[label] != nil {
                            Text(label+": "+String(label_results_returned[label]!))
                        }
                    }
                }
                .listStyle(.plain)
                .padding()
                .onAppear{
                    let binaryImageData = imagelabeller.base64EncodeImage(input_image!)
                    let request = imagelabeller.createRequest(with: binaryImageData)
                    if (request.httpBody != nil) {
                        imagelabeller.runRequestOnBackgroundThread(request) { result in
                            self.label_results_returned = result
                        }
                    }
                }
                
                Button(action: {
                    
                    withAnimation{
                        
                        show.toggle()
                    }
                }) {
                    
                    Text("Close")
                }
                .padding()
            }
        
        }
    }
}
