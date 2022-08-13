//
//  SearchBook.swift
//  GitJsonApp
//
//  Created by Alexander Golub on 13.08.22.
//

import Foundation

struct SearchBook: Decodable {
    var numFound: Int
    var start: Int
    var numFoundExact : Bool
    var docs: [Books]
}
struct Books: Decodable {
    var key: String
    var type: String
    var name: String
    var alternate_names: String?
}
