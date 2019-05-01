//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Alex Ladines on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    //MARK: - Properties
    
    let bookController = BookController()
    
    // Return book from either Read or Unread array
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0
        {
            return bookController.readBooks[indexPath.row]
        }
        else
        {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Don't forget to reload data!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    // Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Header for each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // Only have two title options
        let titles = ["Read","Unread"]
        
        // First and Second titles
        switch section {
        case 0:
            return titles[0]
        default:
            return titles[1]
        }
    }
    
    // Number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Set return statements to computed properties
        switch section {
        case 0:
            return bookController.readBooks.count
        default:
            return bookController.unreadBooks.count
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        cell.book = self.bookFor(indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        // If user decided to delete
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            // Get book from indexPath
            bookController.removeBook(book: self.bookFor(indexPath: indexPath))
            
            // Delete corresponding row from table view
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBook"
        {
            guard let bookDetailVC = segue.destination as? BookDetailViewController
            else
            {
                return
            }
            
            bookDetailVC.bookController = self.bookController
        }
        else if segue.identifier == "EditBook"
        {
            guard let bookDetailVC = segue.destination as? BookDetailViewController
            else
            {
                return
            }
            bookDetailVC.bookController = self.bookController
            
            // Grab cell and its indexPath
            guard let cellTapped = sender as? BookTableViewCell,
            let indexPathOfTappedCell = tableView.indexPath(for: cellTapped)
            else
            {
                return
            }
            
            bookDetailVC.book = self.bookFor(indexPath: indexPathOfTappedCell)
            
        }
    }

}
extension ReadingListTableViewController : BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell)
        else
        {
            return
        }
        
        let book = self.bookFor(indexPath: indexPath)
        
        self.bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    
}

