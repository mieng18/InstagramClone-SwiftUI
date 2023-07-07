//
//  UIApplication+Extension.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/7/23.
//

import SwiftUI


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
