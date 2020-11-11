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
    var bookmarkedBusinesses = [BusinessModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
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
    
}
extension BookmarkedBusinessesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as? BusinessDisplayTableViewCell else {
            fatalError("Error loading Cell")
        }
        return cell
    }
    
    
}
