////
////  Results.swift
////  AroundMeWiki
////
////  Created by Rıdvan İmren on 17.01.2022.
////
//
//import Foundation
//
//struct Result: Codable {
//    let query: Query
//}
//
//struct Query: Codable {
//    let pages: [String: Page]
//    
//}
//
//struct Page: Codable, Comparable, Identifiable{
//    let id = UUID()
//    
//    let pageid: Int
//    let title: String
//    let terms: [String: [String]]?
//    let extract: String?
//    var description: String {
//        terms?["description"]?.first ?? "No further information"
//    }
//    
//    let thumbnail: Thumbnail?
//    static func == (lhs: Page, rhs: Page) -> Bool {
//        lhs.title == rhs.title
//    }
//    
//    let coordinates: [Coordinates]?
//    
//    
//    static func < (lhs: Page, rhs: Page) -> Bool {
//        lhs.title < rhs.title
//    }
//
//    static let example = Page(pageid: 123,
//                              title: "Göksu Parkı",
//                              terms: ["description": ["Description", " " ]],
//                              extract: "Extract Information",
//                              thumbnail: Thumbnail(source: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Ankara_by_night_2013.jpg/500px-Ankara_by_night_2013.jpg", width: 500, height: 325), coordinates: [Coordinates(lat: 39.9902416, lon: 32.6482333)])
//    
////
////    static let example = Page(pageid: 123,
////                              title: "Göksu Parkı",
////                              terms: ["description": ["Description", " " ]],
////                              thumbnail: Thumbnail(source: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Ankara_by_night_2013.jpg/500px-Ankara_by_night_2013.jpg", width: 500, height: 325))
//
//    
//}
//
//struct Thumbnail: Codable {
//    let source: String
//    let width: Int
//    let height: Int
//}
//
//struct Coordinates: Codable {
//    let lat: Double
//    let lon: Double
//}
//
