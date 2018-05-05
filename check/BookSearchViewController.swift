//
//  BookSearchViewController.swift
//  check
//
//  Created by Nandita Mohan on 5/5/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//


import UIKit
import AVFoundation

class BookSearchViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController: UISearchController!
    var timer: Timer?
    
    let bookCellIdentifier = "BookCell"
    
    var books: [Ebook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search eBooks"
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search eBook"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        
    }
    
    // MARK: UITableView Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: bookCellIdentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: bookCellIdentifier)
        
        let book = books[indexPath.row]
        cell.textLabel?.text = book.name
        cell.detailTextLabel?.text = book.author
        cell.detailTextLabel?.alpha = 0.5
        return cell
        
    }
    
    // MARK: UITableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        if let preview = book.previewLink {
            UIApplication.shared.open(preview)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARk: UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(getBooks(_:)), userInfo: ["searchText": searchText], repeats: false)
    }
    
    // MARK: UISearchResults Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            if !searchText.isEmpty {
                //                Network.getTracks(withQuery: searchText) { (songs) in
                //                    self.songs = songs
                //                    self.tableView.reloadData()
                //                }
            }
        }
        
    }
    
    // MARK: Network
    
    @objc func getBooks(_ timer: Timer) {
        
        guard
            let userInfo = timer.userInfo as? [String : String],
            let searchText = userInfo["searchText"]
            else {
                return
        }
        
        Network.getBooks(withQuery: searchText) { (books) in
            self.books = books
            self.tableView.reloadData()
        }
        
    }
    
}

