//
//  RecommendedUserListView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/7/23.
//

import SwiftUI

struct RecommendedUserListView: View {
    
    @Binding var searchText: String
    @ObservedObject var viewModel: SearchViewModel;
    
    func getUsers() -> [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filterUsers(search: searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 10) {
                ForEach(getUsers()) { user in
                    NavigationLink(destination: ProfileView(user: user)) {
                        UserCell(user: user)
                            .padding(.vertical, 5)
                    }
                }
            }
            .padding([.horizontal], 18)
        }
    }
}

struct RecommendedUserListView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedUserListView(
            searchText: .constant(""),
            viewModel: SearchViewModel()
        )
    }
}
