//
//  MapListView.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 20.01.2022.
//

import SwiftUI
//
struct MapListView: View {
    @ObservedObject var viewModel: MapListViewModel
    @EnvironmentObject var language: Language
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(viewModel.pages.data) { page in
                        NavigationLink {
                            DetailView(page: page)
                        } label: {
                            //
                            HStack {
                                Group {
                                    if let thumbnail = page.thumbnail?.source {
                                        if let thumbnailURL = URL(string: thumbnail) {
                                            AsyncImage(url: thumbnailURL) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            
                                        }
                                    } else {
                                        Image("Wiki")
                                            .resizable()
                                            .scaledToFit()
                                        
                                    }
                                }
                                .frame(width:80, height: 80)
                                .clipShape(Circle())
                                
                                Text(page.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                            }
                            
                            .background(.lightBackground)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("Nearby Places")
                        .font(.headline)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    init(pages: Pages) {
        self._viewModel = ObservedObject(wrappedValue: MapListViewModel(pages: pages))
        
    }
}
