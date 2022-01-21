//
//  MapListViewModel.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 20.01.2022.
//

import Foundation

@MainActor class MapListViewModel: ObservableObject {
    @Published var pages =  Pages()
    
    init(pages: Pages) {
        self.pages = pages
    }

}
