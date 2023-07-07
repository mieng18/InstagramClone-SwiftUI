//
//  ExploreTab.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

struct ExploreTab: View {
    
    @State var searchText = ""
    @State var isSearching = false
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $isSearching)
                .padding([.horizontal, .vertical], 15)
            
            ZStack {
                if isSearching {
                    RecommendedUserListView(searchText: $searchText, viewModel: viewModel)
                } else {
                    PostGridView(config: .explore)
                }
            }
            
        }
    }
}

struct ExploreTab_Previews: PreviewProvider {
    static var previews: some View {
        ExploreTab()
    }
}
