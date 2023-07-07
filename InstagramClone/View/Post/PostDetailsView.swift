//
//  PostDetailsView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/6/23.
//

import SwiftUI

struct PostDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: NewPostViewModel
    @Binding var selectedImage: UIImage?
    
    @Binding var selectedTab: Tabs
    @State var captionText = ""
    
    var body: some View {
        VStack {
            
            
            HStack (alignment: .top) {
                Image(uiImage: $selectedImage.wrappedValue ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 96, height: 96)
                    .clipped()
                
                PostCaption(text: $captionText, placeholder: "Write a caption...")
                    .frame(height: 96, alignment: .leading)
                
            }.padding()
            
            CustomButton(action: {
                viewModel.uploadPost(caption: captionText, image: selectedImage!) { _ in
                    captionText = ""
                    selectedImage = nil
                    selectedTab = .home
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Share")
            }, loading: viewModel.isPosting, loadingColor: .white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal, 15)
            
            Spacer()
        }
        .navigationTitle("Upload post")
        .tint(.black)

    }
    
}
