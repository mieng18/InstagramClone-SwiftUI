//
//  UploadNewPostView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/6/23.
//

import SwiftUI

struct UploadNewPostView: View {
    
    @Binding var selectedTab: Tabs
    
    @State var selectedImage: UIImage?
    @State var showImagePicker = false;
    
    @ObservedObject var viewModel = NewPostViewModel()
    
    @State var showDetailsView: Bool = false;
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Button(action: { showImagePicker.toggle() }, label: {
                    Text("Upload Post")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                    .padding()
                    .sheet(
                        isPresented: $showImagePicker,
                        onDismiss: loadImage,
                        content: {
                            ImagePicker(image: $selectedImage)
                        })
            }
            
            NavigationLink(destination:
               PostDetailsView(
                    viewModel: viewModel,
                    selectedImage: $selectedImage,
                    selectedTab: $selectedTab
               )
                .navigationBarHidden(true)

                           
                        ,
               isActive: $showDetailsView) {
                 EmptyView()
            }.hidden()

            
            Spacer()
        }
    }
}

extension UploadNewPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
    
        showDetailsView = true
    }
}
