//
//  MainView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI



enum Tabs: String {
    case home = "Home"
    case explore = "Explore"
    case upload = "Upload"
    case notifications = "Notifications"
    case profile = "Profile"
}


struct MainView: View {
    @State private var selection = "home"
    @State private var mainSelection = "reel"
    
    @State var selectedTab: Tabs = .home

    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
           
                VStack {
                    TabView(selection: $mainSelection){
                        HomeTab()
                            .tag("home")
                            .tabItem {
                                Image(systemName: "house")
                            }
                        ExploreTab()
                            .tag("search")
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                            }
                        
                        UploadNewPostView(selectedTab: $selectedTab)
                            .tag("upload")
                            .tabItem {
                                Image(systemName: "plus.square")
                            }
                        
                        Reels()
                            .tag("reels")
                            .tabItem {
                                Image(systemName: "video")
                            }
                        
                        ProfileView(user: AuthViewModel.shared.currentUser!)
                            .tag("profile")
                            .tabItem {
                                Image(systemName: "person")
                            }
                    }
                    .tabViewStyle(DefaultTabViewStyle())
                    .tint(.black)
                    .onAppear(perform: {
                        let tabBar = UITabBar.appearance()
                        tabBar.backgroundColor = .white
                        tabBar.isTranslucent = true
                    })
                    .padding([.top, .bottom], 0.1)
                    
                }
                .tag("home")
                .background(.white)

            
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .edgesIgnoringSafeArea([.bottom, .top])
            .background(.black)
            .navigationTitle("")
        }
        
        
    }
    
    func goTo(tab: String = "home"){
        withAnimation {
            selection = tab
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
