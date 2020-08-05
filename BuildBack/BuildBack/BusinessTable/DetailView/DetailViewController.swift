//
//  DetailViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 7/8/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailViewController: UIImageView!
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var updateLabel: UILabel!
    
    private var business: BusinessModel
    
    init?(coder: NSCoder, business:BusinessModel){
          self.business = business
          super.init(coder: coder)
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
    override func viewDidLoad() {
        super.viewDidLoad()

       setupDetailPage()
    }
    
    private func setupDetailPage(){
//        companyName.text = bui
        
    }
    
    @IBAction func donateButton(_ sender: RoundedCornerButton) {
    }
    
   

}
