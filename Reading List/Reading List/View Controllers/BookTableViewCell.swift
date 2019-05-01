//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Alex Ladines on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate : AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}

class BookTableViewCell: UITableViewCell {
    
    var book:Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookReadOrUnreadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Set label to title of book and image to read or unread image
    func updateViews() {
        guard let book = book
        else
        {
            return
        }
        
        // Set label
        bookNameLabel.text = book.title
        
        // Set image according to status
        if book.hasBeenRead
        {
            // Set button's image
            self.bookReadOrUnreadButton.setImage(UIImage(named: "checked"), for: .normal)
        }
        else
        {
            // Set button's image
            self.bookReadOrUnreadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        
        
        
    }
    
    @IBAction func bookReadOrUnreadButtonPressed(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
}
