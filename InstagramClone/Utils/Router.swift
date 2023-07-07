//
//  Router.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/6/23.
//

import SwiftUI


enum Route: Hashable {
    case SettingView
    
}

final class Router: ObservableObject {
    @Published var navigationPaths = NavigationPath()
  
    func pushView(route: Route) {
        navigationPaths.append(route)
   }
    
    func popToRootView() {
        navigationPaths = .init()
    }
    
    func popToSpecificView(k: Int){
        navigationPaths.removeLast(k)
    }
   
}

