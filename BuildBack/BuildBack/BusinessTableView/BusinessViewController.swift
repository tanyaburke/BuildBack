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
    private var storageService = StorageService()
    private var businesses = [BusinessModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var buisnessManager = BusinessManager()
    
    //This is set to true only using the bar
    private var currentlySearching = false
    private var filteredBusinesses = [BusinessModel]()
    
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        configureTableView()
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BusinessDisplayTableViewCell", bundle: .main), forCellReuseIdentifier: "businessCell")
        retrieveBuisness()
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
    private func retrieveBuisness(){
        buisnessManager.retriveBusinesses { (result) in
            switch result{
            case let .success(businesses):
                self.businesses = businesses
            case let .failure(error):
                print(error)
            }
        }
    }
    //    override func viewDidAppear(_ animated: Bool) {
    //        listener = Firestore.firestore().collection(<#T##collectionPath: String##String#>)
    //    }
    //
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
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
        var business = businesses[indexPath.row]
        if currentlySearching {
            business = filteredBusinesses[indexPath.row]
        }
        storageService.retrieveItemImages(imageURL: business.imageURL) { (result) in
            switch result{
            case let .success(image):
                cell.configureCell(buisnessName: business.name, buisnessType: business.type, buisnessImage: image)
            case let .failure(error):
                print(error)
            }
        }
        return cell
    }
    
}

//MARK:- Extensions
extension BusinessViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let business =  businesses[indexPath.row]
        print (business.name)
        
        let storyboard =  UIStoryboard(name: "DetailView", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") { (coder) in
            return DetailViewController(coder: coder, business: business)
        }
        navigationController?.pushViewController(detailViewController, animated: true)
        //        present(detailViewController, animated: true)
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
