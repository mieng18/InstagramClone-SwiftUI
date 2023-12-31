//
//  RegisterView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//


import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage


struct RegisterView: View{
    
    @ObservedObject var viewModel: RegisterViewModel = RegisterViewModel()

    // MARK: User Details
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var fullName: String = ""
    @State var userBio: String = ""
    @State var userProfilePicData: Data?
    // MARK: View Properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    // MARK: UserDefaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    
    var body: some View{
        VStack{
            
                Image("instagram")
                .resizable()
                .frame(width: 150, height: 49)
                .hAlign(.center)
                    
            
                // MARK: For Smaller Size Optimization
                ViewThatFits {
                    ScrollView(.vertical, showsIndicators: false) {
                        HelperView()
                    }
                    
                    HelperView()
                }
                
                // MARK: Register Button
                HStack{
                    Text("Already Have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Login Now"){
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                }
                .font(.callout)
                .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
//            LoadingView(show: $isLoading)
        })
        .background(
            LinearGradient(
                           gradient: Gradient(
                               colors: [Color.radientPink1, Color.radientPink2]
                           ),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
        )
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            // MARK: Extracting UIImage From PhotoItem
            if let newValue{
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
                        // MARK: UI Must Be Updated on Main Thread
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                        
                    }catch{}
                }
            }
        }
        // MARK: Displaying Alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    @ViewBuilder
    func HelperView()->some View{
        VStack(spacing: 12){
            ZStack{
                if let userProfilePicData,let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }else{
                    Image("default-profile-image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.textGray.opacity(0.5),lineWidth: 1)
            )
            .onTapGesture {
                showImagePicker.toggle()
            }
            
            
            CustomTextField(text: $userName, placeholder: "Username")
            CustomTextField(text: $fullName, placeholder: "Full name")
            CustomTextField(text: $emailID, placeholder: "Email")
            
            CustomSecureField(text: $password, placeholder: "Password")


            TextField("About You", text: $userBio,axis: .vertical)
                .frame(minHeight: 100,alignment: .top)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            
            Button(action: registerUser){
                // MARK: Login Button
                Text("Sign up")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .disableWithOpacity(userName == "" || fullName == "" || userBio == "" || emailID == "" || password == "" || userProfilePicData == nil)
            .padding(.top,10)
        }
    }
    
    func registerUser(){
        isLoading = true
        closeKeyboard()
        
        guard let imageData = userProfilePicData else{return}
        
        if let userProfilePicData,let image = UIImage(data: imageData){
                       Image(uiImage: image)
                           .resizable()
                           .aspectRatio(contentMode: .fill)
            
            viewModel.register(email: emailID, password: password, username: userName, fullname: fullName,userbio: userBio, photo: image)
        }else{
            Image("NullProfile")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
        }
                   
//
//        viewModel.register(email: emailID, password: password, username: userName, fullname: userBio, photo: image)
        
        
//        Task{
//            do{
//                // Step 1: Creating Firebase Account
//                try await Auth.auth().createUser(withEmail: emailID, password: password)
//                // Step 2: Uploading Profile Photo Into Firebase Storage
//                guard let userUID = Auth.auth().currentUser?.uid else{return}
//                guard let imageData = userProfilePicData else{return}
//                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
//                let _ = try await storageRef.putDataAsync(imageData)
//                // Step 3: Downloading Photo URL
//                let downloadURL = try await storageRef.downloadURL()
//                // Step 4: Creating a User Firestore Object
//                let user = User(username: userName, userBio: userBio, userBioLink: userBioLink, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL)
//                // Step 5: Saving User Doc into Firestore Database
//                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: { error in
//                    if error == nil{
//                        // MARK: Print Saved Successfully
//                        print("Saved Successfully")
//                        userNameStored = userName
//                        self.userUID = userUID
//                        profileURL = downloadURL
//                        logStatus = true
//                    }
//                })
//            }catch{
//                // MARK: Deleting Created Account In Case of Failure
//                try await Auth.auth().currentUser?.delete()
//                await setError(error)
//            }
//        }
    }
    
    // MARK: Displaying Errors VIA Alert
    func setError(_ error: Error)async{
        // MARK: UI Must be Updated on Main Thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}
