//
//  TabBarButton.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/8/23.
//

import SwiftUI

struct TabBarButton: View {
    
    var image: String
    // Since we're having asset Image...
    var isSystemImage: Bool
    var animation: Namespace.ID
    @Binding var selectedTab: String
    
    var body: some View{
        
        Button(action: {
            withAnimation(.easeInOut){
                selectedTab = image
            }
        }, label: {
            VStack(spacing: 12){
                
                (
                    isSystemImage ? Image(systemName: image) : Image(image)
                )
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(selectedTab == image ? .primary : .gray)
                
                ZStack{
                    
                    if selectedTab == image{
                        Rectangle()
                            .fill(Color.primary)
                            // For Smooth sliding effect...
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                    else{
                        Rectangle()
                            .fill(Color.clear)
                    }
                }
                .frame(height: 1)
            }
        })
    }
}
