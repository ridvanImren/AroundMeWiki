//
//  Results.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 17.01.2022.
//

import Foundation
 
class Result: Codable {
    let query: Query
}

class Query: Codable {
    let pages: [String: Page]
    
}

class Page: ObservableObject, Codable, Comparable, Identifiable {

    var id = UUID()
    
    enum CodingKeys: CodingKey {
        case pageid, title, terms, extract, description, thumbnail, coordinates, sa
    }

    @Published var pageid: Int = 0
    @Published var title: String = ""
    @Published var extract: String? = "Extract"
    @Published var sa: String? = nil
    @Published var thumbnail: Thumbnail? = nil
    
    @Published var coordinates: [Coordinates]? = nil
    
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.title == rhs.title
    }

    init() { }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(pageid, forKey: .pageid)
        try container.encode(title, forKey: .title)
        try container.encode(extract, forKey: .extract)
        try container.encode(coordinates, forKey: .coordinates)
        try container.encode(thumbnail, forKey: .thumbnail)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let pageid = try container.decodeIfPresent(Int.self, forKey: .pageid) {
            self.pageid = pageid
        }
        if let title = try container.decodeIfPresent(String.self, forKey: .title) {
            self.title = title
        }
        
        if let coordinates = try container.decodeIfPresent([Coordinates]?.self, forKey: .coordinates) {
            self.coordinates = coordinates
        }

        if let extract = try container.decodeIfPresent(String?.self, forKey: .extract) {
            self.extract = extract
        }
//        sa = try container.decode(String?.self, forKey: .sa)
        if let thumbnail = try container.decodeIfPresent(Thumbnail?.self, forKey: .thumbnail) {
            self.thumbnail = thumbnail
        }
    }
    
    
}

class Thumbnail: Codable {
    let source: String
    let width: Int
    let height: Int
}

class Coordinates: Codable {
    let lat: Double
    let lon: Double
}

import Combine

class Pages: ObservableObject, Identifiable {
    let id = UUID()
    @Published var data = [Page]()
}


