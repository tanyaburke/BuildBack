//
//  BookmarkedBusinessesViewController.swift
//  BuildBack
//
//  Created by Gregory Keeley on 11/11/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class BookmarkedBusinessesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var databaseService = DatabaseService()
    var bookmarkedBusinesses = [BusinessModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUserBookmarkedBusinesses()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchUserBookmarkedBusinesses()
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BusinessDisplayTableViewCell", bundle: .main), forCellReuseIdentifier: "businessCell")
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlFunctions(_ :)), for: .valueChanged)
        
    }
    @objc private func refreshControlFunctions(_ sender: Any) {
        fetchUserBookmarkedBusinesses()
        tableView.reloadData()
        refreshControl.endRefreshing()
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
}


//MARK:- Extensions
extension BookmarkedBusinessesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let maxHeight = tableView.frame.height
        return CGFloat(maxHeight / 4.75)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let business =  bookmarkedBusinesses[indexPath.row]
        let storyboard =  UIStoryboard(name: "DetailView", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") { (coder) in
            return DetailViewController(coder: coder, business: business)
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
extension BookmarkedBusinessesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedBusinesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as? BusinessDisplayTableViewCell else {
            fatalError("Error loading Cell")
        }
        let currentBusiness = bookmarkedBusinesses[indexPath.row]
        if bookmarkedBusinesses.contains(currentBusiness) {
            cell.isBookmarked = true
        }
        cell.configureCell(business: currentBusiness)
        return cell
    }
    
    
}
