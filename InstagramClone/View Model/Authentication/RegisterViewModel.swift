//
//  RegisterViewModel.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var isRegistering: Bool = false
    
    func register(email: String, password: String, username: String, fullname: String,userbio: String?, photo: UIImage?) {
        guard let photo = photo else { return }
        
        isRegistering = true
        
        AuthViewModel.shared.register(
            email: email,
            password: password,
            username: username,
            fullname: fullname,
            photo: photo,
            userbio: userbio
        ) {
            self.isRegistering = false
        }

    }
    
}
