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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUserBookmarkedBusinesses()
    }
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BusinessDisplayTableViewCell", bundle: .main), forCellReuseIdentifier: "businessCell")
    }
    private func fetchUserBookmarkedBusinesses() {
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
        let business = bookmarkedBusinesses[indexPath.row]
        cell.configureCell(business: business)
        return cell
    }
    
    
}
