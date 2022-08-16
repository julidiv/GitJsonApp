//
//  SearchBook.swift
//  GitJsonApp
//

//

import Foundation

struct SearchBook: Decodable {
    var numFound: Int
    var start: Int
    var numFoundExact : Bool
    var docs: [Books]
}
struct Books: Decodable {
    var key: String?
    var type: String?
    var name: String?
    var alternate_names: String?
    
    init(booksData: [String: Any]) {
        key = booksData["name"] as? String
        type = booksData["imageUrl"] as? String
        name = booksData["number_of_lessons"] as? String
        alternate_names = booksData["number_of_tests"] as? String
        
        func getBooks(from value: Any) -> [Books] {
            guard let booksData = value as? [[String: Any]] else { return [] }
            return booksData.compactMap { Books(booksData: $0) }
            
        }
    }
}
