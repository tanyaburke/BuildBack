//
//  ProfileViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    //MARK:- IBOutlets
    
    
    
    //MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
    }
    //MARK:- IBActions
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            try? Auth.auth().signOut()
        }
        guard let loginController = UIStoryboard(name: "LoginViewRefactor", bundle: .main).instantiateInitialViewController(creator: { coder in
                return IntroViewController(coder: coder)
        }) else {
            return
        }
        UIViewController.showviewController(viewController: loginController)
    }
    
   
}
