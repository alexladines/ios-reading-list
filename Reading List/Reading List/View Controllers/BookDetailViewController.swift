//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Alex Ladines on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        // The bookController will be used in both cases
        guard let bookController = self.bookController
        else
        {
            return
        }
        
        // The user is editing an existing book
        if let bookToEdit = self.book
        {
            bookController.updateTitleAndReasonToRead(titled: self.bookNameTextField.text!, withReasonToRead: self.reasonToReadTextView.text, forBook: bookToEdit)
        }
        // The user is saving a new book
        else
        {
            bookController.addBook(titled: self.bookNameTextField.text!, withReasonToRead: self.reasonToReadTextView.text)
        }
    }
    
    func updateViews(){
        // The user is editing an existing book
        if let bookToEdit = self.book
        {
            bookNameTextField.text = bookToEdit.title
            reasonToReadTextView.text = bookToEdit.reasonToRead
            title = bookToEdit.title
        }
        // The user is saving a new book
        else
        {
            title = "Add a new book"
        }
    }
    

}
