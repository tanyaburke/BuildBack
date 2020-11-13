//
//  BusinessViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class BusinessViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var listener: ListenerRegistration?
    private var databaseService = DatabaseService()
    private var storageService = StorageService()
    private var businesses = [BusinessModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var businessManager = BusinessManager()
    
    private var bookmarkedBusinesses = [BusinessModel]() {
        didSet {
            populateBookmarkIDs()
            tableView.reloadData()
        }
    }
    private var bookmarkIDs = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //This is set to true only using the bar
    private var currentlySearching = false
    
    // filteredBusinesses is used to store businesses when searching. Only when currentlySearching is set to true, this becomes the datasource for the tableview
    // By setting this array to hold the filtered (searched) businesses, it avoids having to make network calls on each search for quicker results
    private var filteredBusinesses = [BusinessModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let refreshControl = UIRefreshControl()
    
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        configureTableView()
        fetchUserBookmarkedBusinesses()
    }
    override func viewWillAppear(_ animated: Bool) {
        retrieveAllBusinesses()
        fetchUserBookmarkedBusinesses()
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BusinessDisplayTableViewCell", bundle: .main), forCellReuseIdentifier: "businessCell")
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlFunctions(_ :)), for: .valueChanged)
        retrieveAllBusinesses()
    }
    @objc private func refreshControlFunctions(_ sender: Any) {
        retrieveAllBusinesses()
        fetchUserBookmarkedBusinesses()
        self.refreshControl.endRefreshing()
    }
    private func setupSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.placeholder = "Search for a business"
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.obscuresBackgroundDuringPresentation = false
            controller.automaticallyShowsSearchResultsController = false
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
    private func retrieveAllBusinesses() {
        businessManager.retriveBusinesses { (result) in
            switch result{
            case let .success(businesses):
                self.businesses = businesses
            case let .failure(error):
                print(error)
            }
        }
    }
    private func fetchUserBookmarkedBusinesses() {
        bookmarkedBusinesses.removeAll()
        databaseService.fetchUserBusinessBookmarks { (results) in
            switch results {
            case .failure(let appError):
                print("error: \(appError.localizedDescription)")
            case .success(let businesses):
                self.bookmarkedBusinesses = businesses
            }
        }
    }
    private func populateBookmarkIDs() {
        bookmarkIDs.removeAll()
        for business in bookmarkedBusinesses {
            print(business.documentId)
            bookmarkIDs.append(business.documentId)
        }
    }
    private func searchForBusiness(query: String) {
        currentlySearching = true
        filteredBusinesses = businesses.filter { $0.name.lowercased().contains(query.lowercased()) }
    }
}



extension BusinessViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentlySearching {
            return filteredBusinesses.count
        } else {
            return businesses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as? BusinessDisplayTableViewCell else {
            fatalError("Error loading Cell")
        }
        var currentBusiness = businesses[indexPath.row]
        if currentlySearching {
            currentBusiness = filteredBusinesses[indexPath.row]
        }
        cell.isBookmarked = false
        if bookmarkedBusinesses.contains(currentBusiness) {
            cell.isBookmarked = true
        }
        cell.configureCell(business: currentBusiness)
        return cell
    }
    
}

//MARK:- Extensions
extension BusinessViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return 120
        let maxHeight = tableView.frame.height
        return CGFloat(maxHeight / 4.75)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let business =  businesses[indexPath.row]
        let storyboard =  UIStoryboard(name: "DetailView", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") { (coder) in
            return DetailViewController(coder: coder, business: business)
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}

extension BusinessViewController: UISearchResultsUpdating {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        currentlySearching = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        currentlySearching = false
    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            // TODO: Determine if this is necessary
            currentlySearching = false
            tableView.reloadData()
            return
        }
        searchForBusiness(query: searchText)
        tableView.reloadData()
    }
}
//Use something similar to segue to donate page
//extension BusinessViewController: BusinessCellDelegate {
//
////    func didSelectBusiness( business: Business, businessCell: BusinessDisplayTableViewCell) {
////
////
////            let storyboard =  UIStoryboard(name: "DetailView", bundle: nil)
////            let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") { (coder) in
////                return DetailViewController(coder: coder, business: business)
////            }
////            navigationController?.pushViewController(detailViewController, animated: true)
////    }
//}
