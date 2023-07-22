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
    @State var selectedTab: String = "square.grid.3x3"
    @Namespace var animation
    

    init(user: User) {
        viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        
        NavigationStack(){
            
            VStack(spacing:0) {
                
                HStack(spacing:20){

                    HStack(spacing:6){
                        Text(viewModel.user.username)
                            .font(.system(size: 20, weight: .semibold))
                        
                        Image(systemName:"chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10)
                    }
                    
                    Spacer()
                    Image(systemName:"plus.app")
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

                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]){
                        
                        
                        ProfileHeaderView(viewModel: viewModel)
                            .padding(.top, 16)
                        
                        
                        Section(header:
                                    
                                    // Sticky Top Segmented Bar...
                                HStack(spacing: 0){
                            
                            TabBarButton(image: "square.grid.3x3", isSystemImage: true, animation: animation, selectedTab: $selectedTab)
            
                            TabBarButton(image: "person.crop.square", isSystemImage: true, animation: animation, selectedTab: $selectedTab)
                        }
                                // Max Frame....
                                // Conisered as padding....
                            .frame(height: 50,alignment: .bottom)
                            .background(Color.white))
                        {
                            
                            ZStack{
                                
                                PostGridView(config: .profile(viewModel.user.id ?? ""))
                                    .background(.white)
                                
                            }
                        }
                    }
                })
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

