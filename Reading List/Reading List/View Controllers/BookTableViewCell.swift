//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Alex Ladines on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookReadOrUnreadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func bookReadOrUnreadButtonPressed(_ sender: Any) {
        
    }
    
}
