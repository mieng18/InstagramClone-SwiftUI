//
//  ProfileView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var router = Router()
    @State private var navigateSettingView : Bool = false


    init(user: User) {
        viewModel = ProfileViewModel(user: user);
    }
    
    var body: some View {
        
        NavigationStack(){
            
            VStack {
                
                HStack(spacing:20){
                    Spacer()
                    Image(systemName: "plus.app")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    
         
                    Image("horizontal-line")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 21, height: 18)
                        .onTapGesture {
                            navigateSettingView.toggle()
                            
                        }
                    
                }
                .padding([.leading, .trailing], 16)
                
                ScrollView {
                    VStack (spacing: 32) {
                        ProfileHeaderView(viewModel: viewModel)
                            .padding(.top, 16)
                        PostGridView(config: .profile(viewModel.user.id ?? ""))
                    }
                }
            }
            
            
        }
        .navigationDestination(isPresented: $navigateSettingView) {
                      SettingView()
                .navigationBarHidden(true)

        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: AuthViewModel().currentUser!)
    }
}


struct SettingView: View {

    var body: some View {
        VStack{
            HStack(spacing:20){
                Image(systemName: "chevron.backward")
                Spacer()
        
            }
            
            Spacer()
            HStack {
                Button(action: {
                    Task{
                        await
                        AuthViewModel.shared.signOut()
                    }
                },
                label: {
                    Text("Log out")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black262626)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 29)
                        
                })
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.grayBorder, lineWidth: 0.5)
                )
            }
            .hAlign(.center)
            .padding(.all,16)
            
        }
        
    }
}
