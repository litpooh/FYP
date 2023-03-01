//
//  LoginAndRegister.swift
//  DatabaseFetch
//
//  Created by hi on 5/3/2022.
//

import SwiftUI
import Firebase

class LoginPopUp: ObservableObject {
    @Published var alert = false
    @Published var error = ""

}

class RegisterPopUp: ObservableObject {
    @Published var alert = false
    @Published var error = ""
}



struct Home : View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var email = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    
    var body: some View{
        
        VStack{
            
            if self.status == true {
                
                HomescreenWithTabBar(email: email)
            }
            else{
                
                LoginAndRegisterFit()
            }
        }
        .onAppear {
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                
                self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("email"), object: nil, queue: .main) { (_) in
                
                self.email = UserDefaults.standard.value(forKey: "email") as? String ?? ""
            }
        }
    }
}

struct HomescreenWithTabBar : View {
    @State var selectedTab: Tab = .home
    var email: String
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Group {
                switch selectedTab {
                case .home:
                    Homescreen(email: email)
                case .explore:
                    ManageView(email: email)
//                case .notifications:
//                    ContentView()
//                case .library:
//                    ContentView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            TabBar(selectedTab: $selectedTab)
        }
    }
}

struct HomescreenWithTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HomescreenWithTabBar(email: "")
    }
}


struct Homescreen : View {
    var email: String
    
//    @State var show = false
//    @Namespace var namespace
    @State var selectedItem: Feature? = nil
//    @State var isDisabled = false
    
    var body: some View{
        
        NavigationView {
            ScrollView {
                VStack{
                    HStack(alignment: .bottom){
                        Text("Welcome!")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .padding(.top, 35.0)
                        .foregroundColor(Color.black.opacity(0.7))
                        
                        Spacer()
                        
                        Button(action: {
                            try! Auth.auth().signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                            UserDefaults.standard.set("", forKey: "email")
                            NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
                        }) {
                            Text("Log out")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal)
                                .frame(width: 100)
                        }
                        .background(Color("Color"))
                        .cornerRadius(15)
                        .padding(.top, 25)
                    }
                    .padding(.horizontal)
                    
                    
                    FeatureView(feature: login_features[0])
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                    
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                        spacing: 16
                    ) {
                        ForEach(login_features.dropFirst()) { item in
                            FeatureView(feature: item)
                                .frame(height: 200)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .navigationTitle("")
                    .navigationBarHidden(true)
    //                    .navigationBarItems(leading:
    //                                            Text("Welcome!")
    //                                            .font(.system(size: 48))
    //                                            .fontWeight(.bold)
    //                                            .padding(.top, 35.0)
    //                                            .foregroundColor(Color.black.opacity(0.7))
    //                                        , trailing:
    //                                            Button(action: {
    //                                            try! Auth.auth().signOut()
    //                                            UserDefaults.standard.set(false, forKey: "status")
    //                                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
    //                                            UserDefaults.standard.set("", forKey: "email")
    //                                            NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
    //
    //                                        }) {
    //
    //                                            Text("Log out")
    //                                                .font(.system(size: 18))
    //                                                .foregroundColor(.white)
    //                                                .padding(.vertical)
    //                                                .padding(.horizontal)
    //                                                .frame(width: 100)
    //                                        }
    //                                        .background(Color("Color"))
    //                                        .cornerRadius(15)
    //                                        .padding(.top, 25))
                    
    //                Text("Welcome!"+email)
    //                    .font(.title)
    //                    .fontWeight(.bold)
    //                    .foregroundColor(Color.black.opacity(0.7))
    //
    //                Button(action: {
    //
    //                    try! Auth.auth().signOut()
    //                    UserDefaults.standard.set(false, forKey: "status")
    //                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
    //                    UserDefaults.standard.set("", forKey: "email")
    //                    NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
    //
    //                }) {
    //
    //                    Text("Log out")
    //                        .foregroundColor(.white)
    //                        .padding(.vertical)
    //                        .frame(width: UIScreen.main.bounds.width - 50)
    //                }
    //                .background(Color("Color"))
    //                .cornerRadius(10)
    //                .padding(.top, 25)
                    Spacer()
                        .frame(height: 88)
                }
                
                
            }
        }
        .onAppear{
            UserDefaults.standard.set(0, forKey: "display_point_cpid")
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Homescreen(email: "")
    }
}

struct LoginAndRegisterFit: View {
    var body: some View {
        
        ZStack{
            
            // Background image
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            // Let user to scroll the view if the screen cannot show the full view
            // Otherwise cannot see entire content
            if UIScreen.main.bounds.height > 800{
                
                LoginAndRegister()
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LoginAndRegister()
                }
            }
        }
    }
}

struct LoginAndRegister : View {
    @StateObject var login_popup = LoginPopUp()
    @StateObject var register_popup = RegisterPopUp()
    
    @State var index = 0
    
    var body : some View{
        
        ZStack{
            VStack{
                
                Image("Logo")
                .resizable()
                .frame(width: 200, height: 180)
                
                HStack{
                    
                    Button(action: {
                        
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                            
                           self.index = 0
                        }
                        
                    }) {
                        
                        Text("Sign In")
                            .foregroundColor(self.index == 0 ? .black : .white)
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                        
                    }.background(self.index == 0 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                    
                    Button(action: {
                        
                       withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                           
                          self.index = 1
                       }
                        
                    }) {
                        
                        Text("Sign Up")
                            .foregroundColor(self.index == 1 ? .black : .white)
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                        
                    }.background(self.index == 1 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                    
                }.background(Color.black.opacity(0.1))
                .clipShape(Capsule())
                .padding(.top, 25)
                
                if self.index == 0{
                    
                    ZStack {
                        Login()
                        
    //                    if login_popup.alert {
    //                        LoginErrorView()
    //                    }
                    }
                }
                else{
                    
                    ZStack {
                        Register()
                        
    //                    if register_popup.alert {
    //                        RegisterErrorView()
    //                    }
                    }
                }
                
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
                
                HStack(spacing: 15){
                    
                    Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
                    
                    Text("Requirement")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
                    
                }
                .padding(.top, 10)
                
                HStack(spacing: 20){
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("Network")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.renderingMode(.original)
                            .padding(5)
                        
                    }.background(Color.white)
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("Location")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.renderingMode(.original)
                            .padding(5)
                        
                    }.background(Color.white)
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("Photos")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.renderingMode(.original)
                            .padding(5)
                        
                    }.background(Color.white)
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("Camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.renderingMode(.original)
                            .padding(5)
                        
                    }.background(Color.white)
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                }
                .padding(.top, 10)
                
            }
            .padding()
            
            if self.index == 0 {
                if login_popup.alert {
                    GeometryReader{ proxy in
                        
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView {
                            LoginErrorView2()
                        }
                        .ignoresSafeArea()
                        .frame(width: size.width - 40, height: size.height/2.5, alignment: .center)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
            else {
                if register_popup.alert {
                    GeometryReader{ proxy in
                        
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView {
                            RegisterErrorView2()
                        }
                        .ignoresSafeArea()
                        .frame(width: size.width - 40, height: size.height/2.5, alignment: .center)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
        }
        .environmentObject(login_popup)
        .environmentObject(register_popup)
    }
    
}

struct Login : View {
    
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @EnvironmentObject var login_popup: LoginPopUp
//    @State var alert = false
//    @State var error = ""
    
    var body : some View{
        
        ZStack {
            VStack{
                
                VStack(spacing: 15){
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope")
                            .foregroundColor(.black)
                        
                        TextField("Enter Email Address", text: self.$email)
                            .autocapitalization(.none)
                        
                    }.padding(.vertical, 20)
                    .padding(.horizontal, 30)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    //Divider()
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                        
                        if self.visible{
                            
                            TextField("Password", text: self.$pass)
                            .autocapitalization(.none)
                        }
                        else{
                            
                            SecureField("Password", text: self.$pass)
                            .autocapitalization(.none)
                        }
                        
                        Button(action: {
                            
                            self.visible.toggle()
                            
                        }) {
                            
                            Image(systemName: "eye")
                                .foregroundColor(.black)
                        }
                        
                    }.padding(.vertical, 20)
                    .padding(.horizontal, 30)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                }
                .padding(.vertical)
                //.padding(.horizontal, 20)
                .padding(.bottom, 30)
                //.background(Color.white)
                .cornerRadius(10)
                .padding(.top, 25)
                
                
                Button(action: {
                    
                    self.verify()
                    
                }) {
                    
                    Text("LOGIN")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    
                }.background(
                
                    Color("Color3")
                )
                .cornerRadius(8)
                //.offset(y: -40)
                //.padding(.bottom, -40)
                .shadow(radius: 15)
                
                
                Button(action: {
                    self.reset()
                }) {
                    
                    Text("Forget Password?")
                        .foregroundColor(.white)
                
                }
                .padding(.top, 20)
            }
            
            
            
//            if self.alert{
//
//                ErrorView(alert: self.$alert, error: self.$error)
//            }
        }
    }
    
    func verify(){
        
        if self.email != "" && self.pass != ""{
            
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (result, error) in
                
                if error != nil{
                    
                    login_popup.error = error!.localizedDescription
                    login_popup.alert.toggle()
                    return
                }
                
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                UserDefaults.standard.set(email, forKey: "email")
                NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
            }
        }
        else{
            
            login_popup.error = "Please fill all the contents properly"
            login_popup.alert.toggle()
        }
    }
    
    func reset(){
        
        if self.email != ""{
            
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                
                if err != nil{
                    
                    login_popup.error = err!.localizedDescription
                    login_popup.alert.toggle()
                    return
                }
                
                login_popup.error = "RESET"
                login_popup.alert.toggle()
            }
        }
        else{
            
            login_popup.error = "Email address cannot be found"
            login_popup.alert.toggle()
        }
    }
    
}

struct Register : View {
    
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @EnvironmentObject var register_popup: RegisterPopUp
//    @State var alert = false
//    @State var error = ""
    
    var body : some View{
        
        ZStack {
            VStack{
                VStack(spacing: 15){
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope")
                            .foregroundColor(.black)
                        
                        TextField("Enter Email Address", text: self.$email)
                            .autocapitalization(.none)
                        
                    }.padding(.vertical, 20)
                        .padding(.horizontal, 30)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    //Divider()
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                        
                        if self.visible{
                            
                            TextField("Password", text: self.$pass)
                            .autocapitalization(.none)
                        }
                        else{
                            
                            SecureField("Password", text: self.$pass)
                            .autocapitalization(.none)
                        }
                        
                        Button(action: {
                            
                            self.visible.toggle()
                            
                        }) {
                            
                            Image(systemName: "eye")
                                .foregroundColor(.black)
                        }
                        
                    }.padding(.vertical, 20)
                        .padding(.horizontal, 30)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    //Divider()
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                        
                        if self.revisible{
                            
                            TextField("Re-enter Password", text: self.$repass)
                            .autocapitalization(.none)
                        }
                        else{
                            
                            SecureField("Re-enter Password", text: self.$repass)
                            .autocapitalization(.none)
                        }
                        
                        Button(action: {
                            
                            self.revisible.toggle()
                            
                        }) {
                            
                            Image(systemName: "eye")
                                .foregroundColor(.black)
                        }
                        
                    }.padding(.vertical, 20)
                        .padding(.horizontal, 30)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    
                }
                .padding(.vertical)
                //.padding(.horizontal, 20)
                .padding(.bottom, 30)
                //.background(Color.white)
                .cornerRadius(10)
                .padding(.top, 25)
                
                Button(action: {
                    
                    self.register()
                    
                }) {
                    
                    Text("REGISTER")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    
                }.background(
                    Color("Color3")
                )
                .cornerRadius(8)
                //.offset(y: -40)
                //.padding(.bottom, -40)
                .shadow(radius: 15)
            }
            
//            if self.alert {
//                ErrorView(alert: self.$alert, error: self.$error)
//            }
        }
        
    }
    
    func register(){
        
        if self.email != ""{
            
            if self.pass == self.repass{
                
                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (result, error) in
                    
                    if error != nil{
                        
                        register_popup.error = error!.localizedDescription
                        register_popup.alert.toggle()
                        return
                    }
                    
                    print("success")
                    
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    UserDefaults.standard.set(email, forKey: "email")
                    NotificationCenter.default.post(name: NSNotification.Name("email"), object: nil)
                }
            }
            else{
                
                register_popup.error = "The two passwords are not the same. Please check again."
                register_popup.alert.toggle()
            }
        }
        else{
            
            register_popup.error = "Please make sure all the fields are filled."
            register_popup.alert.toggle()
        }
    }
}

struct LoginErrorView2 : View {
    
    @EnvironmentObject var login_popup: LoginPopUp
    
    var body: some View{
        
        
        VStack{

            HStack{
                
                Spacer()

                if(login_popup.error == "RESET"){
                    Text("Notification")
                        .font(.title)
                        .fontWeight(.bold)
                }
                else {
                    Text("Alert")
                        .font(.title)
                        .fontWeight(.bold)
                }

                Spacer()
            }
            .padding(.horizontal, 25)
            
            if (login_popup.error == "RESET") {
                Text("Reset password link has been sent to your email address. Please check your email box and click on the provided link.")
                    .padding(.top)
                    .padding(.horizontal, 25)
            }
            else {
                Text(login_popup.error)
                    .padding(.top)
                    .padding(.horizontal, 25)
            }

//            Text(login_popup.error == "RESET" ? "Reset password link has been sent to your email address. Please check your email box and click on the provided link." : login_popup.error)
//            .padding(.top)
//            .padding(.horizontal, 25)

            Button(action: {

                login_popup.alert.toggle()

            }) {

                Text("OK")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)

        }
        .navigationBarHidden(true)
        
    }
}

//struct LoginErrorView2_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginErrorView2().environmentObject(LoginPopUp())
//    }
//}

struct RegisterErrorView2 : View {
    
    @EnvironmentObject var register_popup: RegisterPopUp
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                Spacer()
                
                if (register_popup.error == "RESET"){
                    Text("Notification")
                        .font(.title)
                        .fontWeight(.bold)
                }
                else {
                    Text("Alert")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .padding(.horizontal, 25)
            
            if (register_popup.error == "RESET") {
                Text("Reset password link has been sent to your email address. Please check your email box and click on the provided link.")
                    .padding(.top)
                    .padding(.horizontal, 25)
            }
            else {
                Text(register_popup.error)
                    .padding(.top)
                    .padding(.horizontal, 25)
            }
            
//            Text(register_popup.error == "RESET" ? "Reset password link has been sent to your email address. Please check your email box and click on the provided link." : register_popup.error)
//            .padding(.top)
//            .padding(.horizontal, 25)
            
            Button(action: {
                
                register_popup.alert.toggle()
                
            }) {
                
                Text("OK")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)
            
        }
        .navigationBarHidden(true)
        
    }
}
