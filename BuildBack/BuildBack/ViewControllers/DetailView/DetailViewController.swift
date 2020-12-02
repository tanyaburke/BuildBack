//
//  DetailViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 7/8/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    
    //MARK:- Variables and Constants
    private var storageService = StorageService()
    private var business: BusinessModel
    
    //MARK:- Initializers
    init?(coder: NSCoder, business:BusinessModel){
        self.business = business
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailPage()
    }
    
    //MARK:- Functions
    private func setupDetailPage(){
        companyName.text = business.name
        detailLabel.text = business.description
        storageService.retrieveItemImages(imageURL: business.imageURL) { (result) in
            switch result{
            case let .success(image):
                self.detailImageView.image = image
            case let .failure(error):
                print(error)
            }
        }
    }
    
    //MARK:- @IBActions
    @IBAction func donateButton(_ sender: RoundedCornerButton) {
        UIViewController.showViewController(storyBoardName: "Donate", viewControllerId: "DonateViewController")
        ///Code to segue to the Donate View Controller
        //       let storyboard =  UIStoryboard(name: "Donate", bundle: nil)
        //        let donateViewController = storyboard.instantiateViewController(identifier: "DonateViewController") { (coder) in
        //            return DonateViewController(coder:coder) navigationController?.pushViewController(donateViewController, animated: true)
        //        UIViewController.sho
    }
    
}

