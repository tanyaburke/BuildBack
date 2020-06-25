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
    
    
     override func viewDidLoad() {
            super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(BusinessDisplayTableViewCell.self, forCellReuseIdentifier: "businessCell")
        
        }
        
         override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
            
            
        }
    
    
    
}


extension BusinessViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as? BusinessDisplayTableViewCell else {
            fatalError("Error loading Cell")
        }
        cell.backgroundColor = .black
        return cell
    }
    
    
    
    
}
