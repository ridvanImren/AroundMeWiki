//
//  DetailViewModel.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 21.01.2022.
//

import Foundation

extension DetailView {
    @MainActor class DetailViewModel: ObservableObject {
        @Published var language = Language()
        @Published var extractedDescription = ""
        @Published var page: Page
        func fetchPage(_ pageId: Int) async {
    //        let urlString = "https://tr.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&pageids=\(pageId)&exsectionformat=plain"
            let urlString = "https://\(language.wikiLanguage).wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&pageids=\(pageId)&exsectionformat=plain"
            guard let url = URL(string: urlString) else {
                print("URL cannot be created from: \(urlString)")
                return
                
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                print("1")
                let results = try JSONDecoder().decode(Result.self, from: data)
                print("2")
                extractedDescription = results.query.pages.values.first?.extract ?? "N/A"
            } catch {
                print("Extract failed")
            }
            
        }
        
        
        
        init(page: Page) {
            self.page = page

        }
        
        func setup(_ language: Language) {
            self.language = language
        }

    }
}
