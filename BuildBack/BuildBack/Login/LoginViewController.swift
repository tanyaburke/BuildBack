//
//  LoginViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import FirebaseAuth


enum AccountState {
    case existingUser
    case newUser
}

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var signInOrUpLabel: UILabel!
    @IBOutlet weak var signInUpButtonText: UIButton!
    
    @IBOutlet weak var nameTextFeild: UnderlinedTextfield!
    
    @IBOutlet weak var emailTextFeild: UnderlinedTextfield!
    
    @IBOutlet weak var passWordTextFeild: UnderlinedTextfield!
    
    private var accountState: AccountState?
    
    private var authSession = AuthenticationSession()
    
    let dataBaseService = DatabaseService()
    
    init?(coder: NSCoder, accountState: AccountState) {
        self.accountState = accountState
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func signInUpButton(_ sender: UIButton) {
        guard let email = emailTextFeild.text,
            !email.isEmpty,
            let password = passWordTextFeild.text,
            !password.isEmpty else {
                print("missing fields")
                return
        }
        continueLoginFlow(email: email, password: password)
    }
    
    private func continueLoginFlow(email: String, password: String) {
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error): break
                    //                 DispatchQueue.main.async {
                    //                   self?.errorLabel.text = "\(error.localizedDescription)"
                    //                   self?.errorLabel.textColor = .systemRed
                //                 }
                case .success:
                    DispatchQueue.main.async {
                        self?.navigateToMainView()
                    }
                }
            }
        } else {
            authSession.createNewUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error): break
                print(error)
                case let .success(dataresult):
                    guard let self = self, let name = self.nameTextFeild.text else {
                        return
                    }
                    self.dataBaseService.createDatabaseUser(id: dataresult.user.uid, email: email, name: name, completion: { [weak self] in
                        DispatchQueue.main.async {
                            self?.navigateToMainView()
                        }
                    })
                }
            }
        }
    }
    
    
    func navigateToMainView(){
        
        UIViewController.showViewController(storyBoardName: "MainView", viewControllerId: "TabBarViewController")
        
    }
    
    
    
}
