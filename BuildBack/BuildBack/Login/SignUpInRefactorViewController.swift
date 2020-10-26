//
//  SignUpInRefactorViewController.swift
//  BuildBack
//
//  Created by Gregory Keeley on 10/26/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountState {
    case existingUser
    case newUser
}

class SignUpInRefactorViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var nameTextField: UnderlinedTextfield!
    @IBOutlet weak var passwordTextField: UnderlinedTextfield!
    @IBOutlet weak var emailAddressTextField: UnderlinedTextfield!
    
    @IBOutlet weak var signInButton: RoundedCornerButton!
    @IBOutlet weak var signUpButton: RoundedCornerButton!
    @IBOutlet weak var accountInfoLabel: UILabel!
    
    //MARK:- Variables/Constants
    let databaseService = DatabaseService()
    
    private var accountState: AccountState?
    private var authSession = AuthenticationSession()
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- Functions
    private func setupUI() {
        nameTextField.delegate = self
        passwordTextField.delegate = self
        emailAddressTextField.delegate = self
        accountInfoLabel.adjustsFontSizeToFitWidth = true
    }
    private func continueLoginFlow(email: String, password: String) {
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.showAlert(title: "Something went wrong", message: "\(error.localizedDescription)")
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
                case .failure(let error):
                    print(error)
                case let .success(dataresult):
                    guard let self = self, let name = self.nameTextField.text else {
                        return
                    }
                    self.databaseService.createDatabaseUser(id: dataresult.user.uid, email: email, name: name, completion: { [weak self] in
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


//MARK:- Extensions
extension SignUpInRefactorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
