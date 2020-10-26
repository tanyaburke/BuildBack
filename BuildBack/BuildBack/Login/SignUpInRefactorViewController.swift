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
    
    @IBOutlet weak var nameLabel: UILabel!
    //MARK:- Variables/Constants
    let databaseService = DatabaseService()
    
    private var accountState: AccountState = .existingUser
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
        signInButton.titleLabel?.adjustsFontSizeToFitWidth = true
        signUpButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    private func configureUI() {
        if accountState == .existingUser {
            nameTextField.isHidden = true
            nameLabel.isHidden = true
        } else {
            nameTextField.isHidden = false
            nameLabel.isHidden = false
        }
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
    //MARK:- IBActions
    @IBAction func signinButtonPressed(_ sender: RoundedCornerButton) {
        accountState = .existingUser
        signInButton.titleLabel?.text = "Sign In"
        accountInfoLabel.text = "Don't have an account?"
        signUpButton.titleLabel?.text = "Create Account"
        configureUI()
    }
    @IBAction func singUpButtonPressed(_ sender: RoundedCornerButton) {
        accountState = .newUser
        signInButton.titleLabel?.text = "Create Account"
        accountInfoLabel.text = "Already have an account?"
        signUpButton.titleLabel?.text = "Sign In"
        configureUI()
    }
    
}


//MARK:- Extensions
extension SignUpInRefactorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
