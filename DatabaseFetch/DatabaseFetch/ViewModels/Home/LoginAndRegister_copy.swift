//
//  LoginAndRegister.swift
//  DatabaseFetch
//
//  Created by hi on 5/3/2022.
//

//import SwiftUI
//import Firebase
//
//class LoginPopUp: ObservableObject {
//    @Published var alert = false
//    @Published var error = ""
//
//}
//
//class RegisterPopUp: ObservableObject {
//    @Published var alert = false
//    @Published var error = ""
//}
//
//
//
//struct Home : View {
//    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
//    @State var email = UserDefaults.standard.value(forKey: "email") as? String ?? ""
//    
//    var body: some View{
//        
//        VStack{
//            
//            if self.status == true {
//                
//                HomescreenWithTabBar(email: email)
//            }
//            else{
//                
//                LoginAndRegisterFit()
//            }
//        }
//        .onAppear {
//            
//            NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
//                
//                self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
//            }
//            
//            NotificationCenter.default.addObserver(forName: NSNotification.Name("email"), object: nil, queue: .main) { (_) in
//                
//                self.email = UserDefaults.standard.value(forKey: "email") as? String ?? ""
//            }
//        }
//    }
//}
//
//struct HomescreenWithTabBar : View {
//    @State var selectedTab: Tab = .home
//    var email: String
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            
//            Group {
//                switch selectedTab {
//                case .home:
//                    Homescreen(email: email)
//                case .explore:
//                    ContentView()
//                case .notifications:
//                    ContentView()
//                case .library:
//                    ContentView()
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            
//            TabBar(selectedTab: $selectedTab)
//        }
//    }
//}
//
//struct HomescreenWithTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        HomescreenWithTabBar(email: "")
//    }
//}
//
//
//struct Homescreen : View {
//    var email: String
//    
////    @State var show = false
////    @Namespace var namespace
//    @State var selectedItem: Feature? = nil
////    @State var isDisabled = false
//    
//    var body: some View{
//        
//        NavigationView {
//            ScrollView {
//                VStack{
//                    HStack(alignment: .bottom){
//                        Text("Welcome!")
//                        .font(.system(size: 48))
//                        .fontWeight(.bold)
//                        .padding(.top, 35.0)
//                        .foregroundColor(Color.black.opacity(0.7))
//                        
//                        Spacer()
//                        
//                        Button(action: {
//                            try! Auth.auth().signOut()
//                            UserDefaults.standard.set(false, forKey: "status")
//                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
//                            UserDefaults.standard.set("", forKey: "email")
//                            NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
//                        }) {
//                            Text("Log out")
//                                .font(.system(size: 18))
//                                .foregroundColor(.white)
//                                .padding(.vertical)
//                                .padding(.horizontal)
//                                .frame(width: 100)
//                        }
//                        .background(Color("Color"))
//                        .cornerRadius(15)
//                        .padding(.top, 25)
//                    }
//                    .padding(.horizontal)
//                    
//                    
//                    LazyVGrid(
//                        columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
//                        spacing: 16
//                    ) {
//                        ForEach(features) { item in
//                            NavigationLink(destination: ContentView()) {
//                                FeatureView(feature: item)
//                                    .frame(height: 200)
//                            }
//                        }
//                    }
//                    .padding(16)
//                    .frame(maxWidth: .infinity)
//                    .navigationTitle("")
//                    .navigationBarHidden(true)
//    //                    .navigationBarItems(leading:
//    //                                            Text("Welcome!")
//    //                                            .font(.system(size: 48))
//    //                                            .fontWeight(.bold)
//    //                                            .padding(.top, 35.0)
//    //                                            .foregroundColor(Color.black.opacity(0.7))
//    //                                        , trailing:
//    //                                            Button(action: {
//    //                                            try! Auth.auth().signOut()
//    //                                            UserDefaults.standard.set(false, forKey: "status")
//    //                                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
//    //                                            UserDefaults.standard.set("", forKey: "email")
//    //                                            NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
//    //
//    //                                        }) {
//    //
//    //                                            Text("Log out")
//    //                                                .font(.system(size: 18))
//    //                                                .foregroundColor(.white)
//    //                                                .padding(.vertical)
//    //                                                .padding(.horizontal)
//    //                                                .frame(width: 100)
//    //                                        }
//    //                                        .background(Color("Color"))
//    //                                        .cornerRadius(15)
//    //                                        .padding(.top, 25))
//                    
//    //                Text("Welcome!"+email)
//    //                    .font(.title)
//    //                    .fontWeight(.bold)
//    //                    .foregroundColor(Color.black.opacity(0.7))
//    //
//    //                Button(action: {
//    //
//    //                    try! Auth.auth().signOut()
//    //                    UserDefaults.standard.set(false, forKey: "status")
//    //                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
//    //                    UserDefaults.standard.set("", forKey: "email")
//    //                    NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
//    //
//    //                }) {
//    //
//    //                    Text("Log out")
//    //                        .foregroundColor(.white)
//    //                        .padding(.vertical)
//    //                        .frame(width: UIScreen.main.bounds.width - 50)
//    //                }
//    //                .background(Color("Color"))
//    //                .cornerRadius(10)
//    //                .padding(.top, 25)
//                }
//                
//                
//            }
//        }
//    }
//}
//
//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        Homescreen(email: "")
//    }
//}
//
//struct LoginAndRegisterFit: View {
//    var body: some View {
//        
//        ZStack{
//            
//            // Background image
//            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
//            
//            // Let user to scroll the view if the screen cannot show the full view
//            // Otherwise cannot see entire content
//            if UIScreen.main.bounds.height > 800{
//                
//                LoginAndRegister()
//            }
//            else{
//                
//                ScrollView(.vertical, showsIndicators: false) {
//                    
//                    LoginAndRegister()
//                }
//            }
//        }
//    }
//}
//
//struct LoginAndRegister : View {
//    @StateObject var login_popup = LoginPopUp()
//    @StateObject var register_popup = RegisterPopUp()
//    
//    @State var index = 0
//    
//    var body : some View{
//        
//        ZStack{
//            VStack{
//                
//                Image("logo")
//                .resizable()
//                .frame(width: 200, height: 180)
//                
//                HStack{
//                    
//                    Button(action: {
//                        
//                        withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
//                            
//                           self.index = 0
//                        }
//                        
//                    }) {
//                        
//                        Text("Existing")
//                            .foregroundColor(self.index == 0 ? .black : .white)
//                            .fontWeight(.bold)
//                            .padding(.vertical, 10)
//                            .frame(width: (UIScreen.main.bounds.width - 50) / 2)
//                        
//                    }.background(self.index == 0 ? Color.white : Color.clear)
//                    .clipShape(Capsule())
//                    
//                    Button(action: {
//                        
//                       withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
//                           
//                          self.index = 1
//                       }
//                        
//                    }) {
//                        
//                        Text("New")
//                            .foregroundColor(self.index == 1 ? .black : .white)
//                            .fontWeight(.bold)
//                            .padding(.vertical, 10)
//                            .frame(width: (UIScreen.main.bounds.width - 50) / 2)
//                        
//                    }.background(self.index == 1 ? Color.white : Color.clear)
//                    .clipShape(Capsule())
//                    
//                }.background(Color.black.opacity(0.1))
//                .clipShape(Capsule())
//                .padding(.top, 25)
//                
//                if self.index == 0{
//                    
//                    ZStack {
//                        Login()
//                        
//    //                    if login_popup.alert {
//    //                        LoginErrorView()
//    //                    }
//                    }
//                }
//                else{
//                    
//                    ZStack {
//                        SignUp()
//                        
//    //                    if register_popup.alert {
//    //                        RegisterErrorView()
//    //                    }
//                    }
//                }
//                
//                if self.index == 0{
//                    
//                    Button(action: {
//                        
//                    }) {
//                        
//                        Text("Forget Password?")
//                            .foregroundColor(.white)
//                    
//                    }
//                    .padding(.top, 20)
//                }
//                
//                HStack(spacing: 15){
//                    
//                    Color.white.opacity(0.7)
//                    .frame(width: 35, height: 1)
//                    
//                    Text("Or")
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                    
//                    Color.white.opacity(0.7)
//                    .frame(width: 35, height: 1)
//                    
//                }
//                .padding(.top, 10)
//                
//                HStack{
//                    
//                    Button(action: {
//                        
//                    }) {
//                        
//                        Image("fb")
//                            .renderingMode(.original)
//                            .padding()
//                        
//                    }.background(Color.white)
//                    .clipShape(Circle())
//                    
//                    Button(action: {
//                        
//                    }) {
//                        
//                        Image("google")
//                            .renderingMode(.original)
//                            .padding()
//                        
//                    }.background(Color.white)
//                    .clipShape(Circle())
//                    .padding(.leading, 25)
//                }
//                .padding(.top, 10)
//                
//            }
//            .padding()
//            
//            if self.index == 0 {
//                if login_popup.alert {
//                    NavigationView{
//                        Text("")
//                            .navigationBarHidden(true)
//                    }
//                    .PopUpNavigationView(horizontalPadding: 40, show: $login_popup.alert) {
//                        LoginErrorView2()
//                    }
//                }
//            }
//            else {
//                if register_popup.alert {
//                    RegisterErrorView()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                }
//            }
//        }
//        .environmentObject(login_popup)
//        .environmentObject(register_popup)
//    }
//}
//
//struct Login : View {
//    
//    @State var email = ""
//    @State var pass = ""
//    @State var visible = false
//    @EnvironmentObject var login_popup: LoginPopUp
////    @State var alert = false
////    @State var error = ""
//    
//    var body : some View{
//        
//        ZStack {
//            VStack{
//                
//                VStack{
//                    
//                    HStack(spacing: 15){
//                        
//                        Image(systemName: "envelope")
//                            .foregroundColor(.black)
//                        
//                        TextField("Enter Eemail Address", text: self.$email)
//                            .autocapitalization(.none)
//                        
//                    }.padding(.vertical, 20)
//                    
//                    Divider()
//                    
//                    HStack(spacing: 15){
//                        
//                        Image(systemName: "lock")
//                        .resizable()
//                        .frame(width: 15, height: 18)
//                        .foregroundColor(.black)
//                        
//                        if self.visible{
//                            
//                            TextField("Password", text: self.$pass)
//                            .autocapitalization(.none)
//                        }
//                        else{
//                            
//                            SecureField("Password", text: self.$pass)
//                            .autocapitalization(.none)
//                        }
//                        
//                        Button(action: {
//                            
//                            self.visible.toggle()
//                            
//                        }) {
//                            
//                            Image(systemName: "eye")
//                                .foregroundColor(.black)
//                        }
//                        
//                    }.padding(.vertical, 20)
//                    
//                }
//                .padding(.vertical)
//                .padding(.horizontal, 20)
//                .padding(.bottom, 40)
//                .background(Color.white)
//                .cornerRadius(10)
//                .padding(.top, 25)
//                
//                
//                Button(action: {
//                    
//                    self.verify()
//                    
//                }) {
//                    
//                    Text("LOGIN")
//                        .foregroundColor(.white)
//                        .fontWeight(.bold)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 100)
//                    
//                }.background(
//                
//                    LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
//                )
//                .cornerRadius(8)
//                .offset(y: -40)
//                .padding(.bottom, -40)
//                .shadow(radius: 15)
//            }
//            
////            if self.alert{
////
////                ErrorView(alert: self.$alert, error: self.$error)
////            }
//        }
//    }
//    
//    func verify(){
//        
//        if self.email != "" && self.pass != ""{
//            
//            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
//                
//                if err != nil{
//                    
//                    login_popup.error = err!.localizedDescription
//                    login_popup.alert.toggle()
//                    return
//                }
//                
//                print("success")
//                UserDefaults.standard.set(true, forKey: "status")
//                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
//                UserDefaults.standard.set(email, forKey: "email")
//                NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
//            }
//        }
//        else{
//            
//            login_popup.error = "Please fill all the contents properly"
//            login_popup.alert.toggle()
//        }
//    }
//}
//
//struct SignUp : View {
//    
//    @State var email = ""
//    @State var pass = ""
//    @State var repass = ""
//    @State var visible = false
//    @State var revisible = false
//    @EnvironmentObject var register_popup: RegisterPopUp
////    @State var alert = false
////    @State var error = ""
//    
//    var body : some View{
//        
//        ZStack {
//            VStack{
//                VStack{
//                    
//                    HStack(spacing: 15){
//                        
//                        Image(systemName: "envelope")
//                            .foregroundColor(.black)
//                        
//                        TextField("Enter Eemail Address", text: self.$email)
//                            .autocapitalization(.none)
//                        
//                    }.padding(.vertical, 20)
//                    
//                    Divider()
//                    
//                    HStack(spacing: 15){
//                        
//                        Image(systemName: "lock")
//                        .resizable()
//                        .frame(width: 15, height: 18)
//                        .foregroundColor(.black)
//                        
//                        if self.visible{
//                            
//                            TextField("Password", text: self.$pass)
//                            .autocapitalization(.none)
//                        }
//                        else{
//                            
//                            SecureField("Password", text: self.$pass)
//                            .autocapitalization(.none)
//                        }
//                        
//                        Button(action: {
//                            
//                            self.visible.toggle()
//                            
//                        }) {
//                            
//                            Image(systemName: "eye")
//                                .foregroundColor(.black)
//                        }
//                        
//                    }.padding(.vertical, 20)
//                    
//                    Divider()
//                    
//                    HStack(spacing: 15){
//                        
//                        Image(systemName: "lock")
//                        .resizable()
//                        .frame(width: 15, height: 18)
//                        .foregroundColor(.black)
//                        
//                        if self.revisible{
//                            
//                            TextField("Re-enter Password", text: self.$repass)
//                            .autocapitalization(.none)
//                        }
//                        else{
//                            
//                            SecureField("Re-enter Password", text: self.$repass)
//                            .autocapitalization(.none)
//                        }
//                        
//                        Button(action: {
//                            
//                            self.revisible.toggle()
//                            
//                        }) {
//                            
//                            Image(systemName: "eye")
//                                .foregroundColor(.black)
//                        }
//                        
//                    }.padding(.vertical, 20)
//                    
//                    
//                }
//                .padding(.vertical)
//                .padding(.horizontal, 20)
//                .padding(.bottom, 40)
//                .background(Color.white)
//                .cornerRadius(10)
//                .padding(.top, 25)
//                
//                Button(action: {
//                    
//                    self.register()
//                    
//                }) {
//                    
//                    Text("SIGNUP")
//                        .foregroundColor(.white)
//                        .fontWeight(.bold)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 100)
//                    
//                }.background(
//                
//                    LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
//                )
//                .cornerRadius(8)
//                .offset(y: -40)
//                .padding(.bottom, -40)
//                .shadow(radius: 15)
//            }
//            
////            if self.alert {
////                ErrorView(alert: self.$alert, error: self.$error)
////            }
//        }
//        
//    }
//    
//    func register(){
//        
//        if self.email != ""{
//            
//            if self.pass == self.repass{
//                
//                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
//                    
//                    if err != nil{
//                        
//                        register_popup.error = err!.localizedDescription
//                        register_popup.alert.toggle()
//                        return
//                    }
//                    
//                    print("success")
//                    
//                    UserDefaults.standard.set(true, forKey: "status")
//                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
//                    UserDefaults.standard.set(email, forKey: "email")
//                    NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
//                }
//            }
//            else{
//                
//                register_popup.error = "Password mismatch"
//                register_popup.alert.toggle()
//            }
//        }
//        else{
//            
//            register_popup.error = "Please fill all the contents properly"
//            register_popup.alert.toggle()
//        }
//    }
//}
//
//struct LoginErrorView2 : View {
//    
//    @State var color = Color.black.opacity(0.7)
//    @EnvironmentObject var login_popup: LoginPopUp
////    @Binding var alert : Bool
////    @Binding var error : String
//    
//    var body: some View{
//        
//        
//        VStack{
//
//            HStack{
//
//                Text(login_popup.error == "RESET" ? "Message" : "Error")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(self.color)
//
//                Spacer()
//            }
//            .padding(.horizontal, 25)
//
//            Text(login_popup.error == "RESET" ? "Password reset link has been sent successfully" : login_popup.error)
//            .foregroundColor(self.color)
//            .padding(.top)
//            .padding(.horizontal, 25)
//
//            Button(action: {
//
//                login_popup.alert.toggle()
//
//            }) {
//
//                Text(login_popup.error == "RESET" ? "Ok" : "Cancel")
//                    .foregroundColor(.white)
//                    .padding(.vertical)
//                    .frame(width: UIScreen.main.bounds.width - 120)
//            }
//            .background(Color("Color"))
//            .cornerRadius(10)
//            .padding(.top, 25)
//
//        }
//        
//    }
//}
//
//struct LoginErrorView2_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginErrorView2().environmentObject(LoginPopUp())
//    }
//}
//
//
//
//struct LoginErrorView : View {
//    
//    @State var color = Color.black.opacity(0.7)
//    @EnvironmentObject var login_popup: LoginPopUp
////    @Binding var alert : Bool
////    @Binding var error : String
//    
//    var body: some View{
//        
//        
//        GeometryReader{_ in
//            
//            Color.primary
//                .opacity(0.15)
//                .ignoresSafeArea()
//
//            VStack{
//
//                HStack{
//
//                    Text(login_popup.error == "RESET" ? "Message" : "Error")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(self.color)
//
//                    Spacer()
//                }
//                .padding(.horizontal, 25)
//
//                Text(login_popup.error == "RESET" ? "Password reset link has been sent successfully" : login_popup.error)
//                .foregroundColor(self.color)
//                .padding(.top)
//                .padding(.horizontal, 25)
//
//                Button(action: {
//
//                    login_popup.alert.toggle()
//
//                }) {
//
//                    Text(login_popup.error == "RESET" ? "Ok" : "Cancel")
//                        .foregroundColor(.white)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 120)
//                }
//                .background(Color("Color"))
//                .cornerRadius(10)
//                .padding(.top, 25)
//
//            }
//            .padding(.vertical, 25)
//            .frame(width: UIScreen.main.bounds.width - 70, height: UIScreen.main.bounds.height/1.2, alignment: .center)
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//            .background(Color.white)
//            .cornerRadius(15)
//        }
//        //.background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
//    }
//}
//
//struct RegisterErrorView : View {
//    
//    @State var color = Color.black.opacity(0.7)
//    @EnvironmentObject var register_popup: RegisterPopUp
////    @Binding var alert : Bool
////    @Binding var error : String
//    
//    var body: some View{
//        
//        GeometryReader{ proxy in
//            
//            Color.primary
//                .opacity(0.35)
//                .ignoresSafeArea()
//            
//            let size = proxy.size
//            
//            VStack{
//                
//                HStack{
//                    
//                    Text(register_popup.error == "RESET" ? "Message" : "Error")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(self.color)
//                    
//                    Spacer()
//                }
//                .padding(.horizontal, 25)
//                
//                Text(register_popup.error == "RESET" ? "Password reset link has been sent successfully" : register_popup.error)
//                .foregroundColor(self.color)
//                .padding(.top)
//                .padding(.horizontal, 25)
//                
//                Button(action: {
//                    
//                    register_popup.alert.toggle()
//                    
//                }) {
//                    
//                    Text(register_popup.error == "RESET" ? "Ok" : "Cancel")
//                        .foregroundColor(.white)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 120)
//                }
//                .background(Color("Color"))
//                .cornerRadius(10)
//                .padding(.top, 25)
//                
//            }
//            .padding(.vertical, 25)
//            .frame(width: size.width - 70, height: size.height/4, alignment: .center)
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//            .background(Color.white)
//            .cornerRadius(15)
//        }
//        //.background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
//        
//    }
//}
//
//
//struct RegisterErrorView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterErrorView().environmentObject(RegisterPopUp())
//    }
//}
//
