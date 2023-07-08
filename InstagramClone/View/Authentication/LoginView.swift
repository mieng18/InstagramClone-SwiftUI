//
//  LoginView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    @State var emailID: String = ""
    @State var password: String = ""
    // MARK: View Properties
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    var body: some View {
        VStack(spacing: 0){
            
    
            Image("instagram")
            .resizable()
            .frame(width: 150, height: 49)
            .padding(.bottom, 12)
            
            VStack(spacing: 12){
                CustomTextField(text: $emailID, placeholder: "Email")
                CustomSecureField(text: $password, placeholder: "Password")

                
                Button("Reset password?", action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.trailing)
                
                Button(action: loginUser){
                    // MARK: Login Button
                    Text("Log in")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .padding(.top,10)
            }
            
            // MARK: Register Button
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                Button("Register Now"){
                    createAccount.toggle()
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        
        .vAlign(.top)
        .padding(15)
        .background(
            LinearGradient(
                           gradient: Gradient(
                               colors: [Color.radientPink1, Color.radientPink2]
                           ),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
        )
        .overlay(content: {
//            LoadingView(show: $isLoading)
        })
        // MARK: Register View VIA Sheets
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
        }
        // MARK: Displaying Alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    func loginUser(){
        isLoading = true
        closeKeyboard()
        viewModel.login(email: emailID, password: password)
    }
    
    func resetPassword(){
        Task{
            do{
                // With the help of Swift Concurrency Auth can be done with Single Line
//                try await AuthViewModel().auth().sendPasswordReset(withEmail: emailID)
                print("Link Sent")
            }catch{
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error)async{
        // MARK: UI Must be Updated on Main Thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

extension View{
    // Closing All Active Keyboards
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: Disabling with Opacity
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxWidth: .infinity,alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxHeight: .infinity,alignment: alignment)
    }
    
    // MARK: Custom Border View With Padding
    func border(_ width: CGFloat,_ color: Color)->some View{
        self
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    // MARK: Custom Fill View With Padding
    func fillView(_ color: Color)->some View{
        self
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.leading,18)
                    .textInputAutocapitalization(.never)
            }
            
            HStack {
                
                TextField("", text: $text)
                    .foregroundColor(.black.opacity(0.9))
                    .autocapitalization(.none)
                    .padding(.leading,0 )
                    .textInputAutocapitalization(.none)
            }
            .padding(.all,10)
            .padding(.horizontal, 5)
            .background(Color(.init(white: 1, alpha: 0.7)))
            .cornerRadius(8)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.purple, Color.blue]
                ),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
            
            VStack {
                CustomTextField(
                    text: .constant(""), placeholder: "My placeholder"
                )
            }.padding()
        }
    }
}


struct CustomSecureField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.leading,18)
                    .textInputAutocapitalization(.never)
            }
            
            HStack {
            
                SecureField("", text: $text)
                    .foregroundColor(.black.opacity(0.9))
                    .padding(.leading,0)
                    .textInputAutocapitalization(.never)
            }
            .padding(.all,10)
            .padding(.horizontal, 5)
            .background(Color(.init(white: 1, alpha: 0.7)))
            .cornerRadius(8)
        }
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.purple, Color.blue]
                ),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
            
            VStack {
                CustomSecureField(
                    text: .constant(""), placeholder: "My placeholder"
                )
            }.padding()
        }
    }
}
