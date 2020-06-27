//
//  BusinessViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var storageService = StorageService()
    
    private var businesses = [BusinessModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var buisnessManager = BusinessManager()
    
     override func viewDidLoad() {
            super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UINib(nibName: "BusinessDisplayTableViewCell", bundle: .main), forCellReuseIdentifier: "businessCell")
        retrieveBuisness()
        
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
}


extension BusinessViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as? BusinessDisplayTableViewCell else {
            fatalError("Error loading Cell")
        }
        let buisness = businesses[indexPath.row]
        storageService.retrieveItemImages(imageURL: buisness.imageURL) { (result) in
            switch result{
            case let .success(image):
                cell.configureCell(buisnessName: buisness.name, buisnessType: buisness.type, buisnessImage: image)
                
            case let .failure(error):
                print(error)
            }
        }
        
        return cell
    }
    
    
    
    
}
