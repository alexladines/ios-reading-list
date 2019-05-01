//
//  BookController.swift
//  Reading List
//
//  Created by Alex Ladines on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    // Read Books Array
    var readBooks: [Book] {
        get {
            return books.filter { $0.hasBeenRead == true }
        }
    }
    // Unread Books Array
    var unreadBooks: [Book] {
        get {
            return books.filter { $0.hasBeenRead == false }
        }
    }
    
    init() {
        // Hard coded data for testing
        self.addBook(titled: "A", withReasonToRead: "I like anarchy.")
        self.addBook(titled: "B", withReasonToRead: "Last time I read it was in high school.")
        self.addBook(titled: "C", withReasonToRead: "Friend recommended this murder mystery.")
    }
    
    private var persistentURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            else
        {
            return nil
        }
        
        // print("Documents :\(documents.path)")
        return documents.appendingPathComponent("ReadingList.plist")
    }

    // Add a new book
    func addBook(titled title: String, withReasonToRead reasonToRead: String) {
        books.append(Book(title: title, reasonToRead: reasonToRead))
        
        // Save when adding a book
        self.saveToPersistentStore()
    }
    
    // Update the hasBeenRead property
    func updateHasBeenRead(for book: Book) {
        book.hasBeenRead = !book.hasBeenRead
        
        // Save when updating a book's properties
        self.saveToPersistentStore()
    }
    // Update title and reasonToRead properties
    func updateTitleAndReasonToRead(titled title: String, withReasonToRead reasonToRead: String, forBook book: Book) {
        if let i = books.firstIndex(of: book)
        {
            books[i].title = title
            books[i].reasonToRead = reasonToRead
        }
        
        // Save when updating a book's properties
        self.saveToPersistentStore()
    }
    
    // Remove a book
    func removeBook(book: Book) {
        books.removeAll { $0 == book }
        
        // Save when deleting a book
        self.saveToPersistentStore()
    }
    
    
    // Save to disk
    func saveToPersistentStore() {
        guard let url = persistentURL
            else
        {
            return
        }
        
        do
        {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        }
        catch
        {
            print("Error saving books: \(error)")
        }
    }
    
    // Load from disk
    func loadFromPersistentStore() {
        // Make sure file exists
        let fileManager = FileManager.default
        guard let url = persistentURL, fileManager.fileExists(atPath: url.path)
            else
        {
            print("Load failed to find file.")
            return
            
        }
        
        // Load and decode
        do
        {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        }
        catch
        {
            print("Error loading data from disk: \(error)")
        }
    }
    
    
}
extension BookController {
    func testMethods() {
        
        // Print initial books
        for book in self.books
        {
            print(book)
        }
        
        print("\n")
        
        // Test adding books
        self.addBook(titled: "The Prince", withReasonToRead: "I should be aware of Machiavellianism.")
        self.addBook(titled: "Communist Manifesto", withReasonToRead: "I should be aware of the dangers of communism.")
        
        // Print list of books post adding two
        for book in self.books
        {
            print(book)
        }
        
        print("\n")
        
        // Test update property
        guard let firstBook = self.books.first,
            let lastBook = self.books.last
            else
        {
            return
        }
        
        // Set to read
        self.updateHasBeenRead(for: firstBook)
        self.updateHasBeenRead(for: lastBook)
        
        // Set back to unread
        self.updateHasBeenRead(for: firstBook)
        self.updateHasBeenRead(for: lastBook)
        
        // Set first book back to read
        self.updateHasBeenRead(for: firstBook)
        
        // Print list of books post updating hasBeenRead property
        for book in self.books
        {
            print(book)
        }
        
        print("\n")
        
        // Test second update property
        self.updateTitleAndReasonToRead(titled: "And Then There Were None", withReasonToRead: "I like mysteries", forBook: firstBook)
        self.updateTitleAndReasonToRead(titled: "Fight Club", withReasonToRead: "It's my favorite book.", forBook: lastBook)
        
        // Print list of books post updating the other two properties
        for book in self.books
        {
            print(book)
        }
        
        print("\n")
        
        // Test remove method on the first and last books
        self.removeBook(book: firstBook)
        self.removeBook(book: lastBook)
        
        // Print list of books post removing the first and last books
        for book in self.books
        {
            print(book)
        }
        
        print("\n")
        
        // Test printing out read and unread books computed property, should be 0 and 3 books
        let readBooks:[Book] = self.readBooks
        print("\(readBooks.count) books in read book array.")
        
        let unreadBooks:[Book] = self.unreadBooks
        print("\(unreadBooks.count) books in unread book array.")
        
        
    }
}
