//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isLogging: Bool = false;
    
    func login(email: String, password: String) {
        self.isLogging = true
        
        AuthViewModel.shared.login(withEmail: email, password: password) {
            self.isLogging = false
        }
    }

}
