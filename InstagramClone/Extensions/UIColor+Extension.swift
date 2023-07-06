//
//  UIColor+Extension.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

extension Color {
    static let pink = 0xD66972
    

    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}


extension Color {

    static let textGray = Color(0x93979F)
    static let radientPink2 = Color(0xF0BCC9)
    static let radientPink1 = Color(0xEBD1DB)



}
