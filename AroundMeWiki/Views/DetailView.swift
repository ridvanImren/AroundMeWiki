//
//  DetailView.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 17.01.2022.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var language: Language
    @StateObject var viewModel: DetailViewModel
    var body: some View {
        
        NavigationView{
            ScrollView() {
                VStack() {
                    Group {
                        if let thumbnail = viewModel.page.thumbnail {
                            AsyncImage(url: URL(string: thumbnail.source)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: CGFloat(thumbnail.height))
                            
                        } else {
                            Image("Wiki")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Text(viewModel.extractedDescription)
                        .lineSpacing(8)
                        .padding([.bottom])
                    Link(destination: URL(string: "https://\(language.wikiLanguage).m.wikipedia.org/?curid=\(viewModel.page.pageid)")!) {
                        Label("Visit Wikipedia for more", systemImage: "arrowshape.turn.up.forward.fill")
                    }
                }
                .navigationTitle(viewModel.page.title)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            .padding()
            .background(.lightBackground)
            
        }
        .task {
            await viewModel.fetchPage(viewModel.page.pageid)
        }
        .onAppear {
            self.viewModel.setup(self.language)
            
        }
    }
    
    init(page: Page) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(page: page))
    }
}
//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(page: Page.example)
//    }
//}
