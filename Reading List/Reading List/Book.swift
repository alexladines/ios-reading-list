//
//  Book.swift
//  Reading List
//
//  Created by Alex Ladines on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class Book : Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
    
    // Equatable Protocol
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
}

//Make print(Book) look good
extension Book : CustomStringConvertible {
    var description: String {
        return "Book title: \(self.title), reason to read: \(self.reasonToRead), has been read: \(self.hasBeenRead)"
    }
}
