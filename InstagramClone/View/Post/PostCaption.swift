//
//  PostCaption.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/6/23.
//

import SwiftUI

struct PostCaption: View {
    
    @Binding var text: String;
    var placeholder: String;
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            TextEditor(text: $text)
                .padding(4)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
                    .allowsHitTesting(false)
            }
        }
        .font(.body)
    }
}

struct PostCaption_Previews: PreviewProvider {
    static var previews: some View {
        PostCaption(text: .constant(""), placeholder: "My Field")
    }
}
