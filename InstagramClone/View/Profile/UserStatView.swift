//
//  UserStatView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

struct UserStatView: View {
    var title: String!;
    var value: Int!;
    
    var body: some View {
        VStack {
            Text(String(value ?? 0))
                .font(.system(size: 18, weight: .semibold))
            
            Text(String(title))
                .font(.system(size: 15))
        }
        .frame(width: 75, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(title: "Title", value: 10)
    }
}
