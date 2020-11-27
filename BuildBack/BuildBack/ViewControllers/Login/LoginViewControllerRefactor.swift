//
//  SignUpInRefactorViewController.swift
//  BuildBack
//
//  Created by Gregory Keeley on 10/26/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import FirebaseAuth

// This enum determines the status of a user when using the app
enum AccountState {
    case existingUser
    case newUser
}

class LoginViewControllerRefactor: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var nameTextField: UnderlinedTextfield!
    @IBOutlet weak var passwordTextField: UnderlinedTextfield!
    @IBOutlet weak var emailAddressTextField: UnderlinedTextfield!
    
    @IBOutlet weak var topButton: RoundedCornerButton!
    @IBOutlet weak var bottomButton: RoundedCornerButton!
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
        configureLoginInfoStack()
    }
    
    //MARK:- Functions
    private func setupUI() {
        nameTextField.delegate = self
        passwordTextField.delegate = self
        emailAddressTextField.delegate = self
        accountInfoLabel.adjustsFontSizeToFitWidth = true
        topButton.titleLabel?.adjustsFontSizeToFitWidth = true
        bottomButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    // Determines whether or not a user is creating a new account, or signing into an existing one
    private func configureLoginInfoStack() {
        if accountState == .existingUser {
            nameTextField.isHidden = true
            nameLabel.isHidden = true
        } else {
            nameTextField.isHidden = false
            nameLabel.isHidden = false
        }
    }
    
    // Used sign-in (if existing user), or create an account
    private func continueLoginFlow(email: String, password: String) {
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.showAlert(title: "Something went wrong", message: "\(error.localizedDescription)")
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
    
    // Used to navigate to the main view of the app
    func navigateToMainView(){
        UIViewController.showViewController(storyBoardName: "MainView", viewControllerId: "TabBarViewController")
    }
    
    // Determines the signin/create account button stack depending on the user status (newUser or existingUser)
    private func configureLoginButtons() {
        if accountState == .existingUser {
            topButton.setTitle("Sign In", for: .normal)
            accountInfoLabel.text = "Don't have an account?"
            bottomButton.setTitle("Create Account", for: .normal)
            configureLoginInfoStack()
        } else {
            accountState = .newUser
            topButton.setTitle("Create Account", for: .normal)
            accountInfoLabel.text = "Already have an account?"
            bottomButton.setTitle("Sign In", for: .normal)
            configureLoginInfoStack()
        }
        
    }
    
    //MARK:- IBActions
    @IBAction func topButtonPressed(_ sender: RoundedCornerButton) {
        // Sign in or create account functions go here
        guard let email = emailAddressTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Something is missing", message: "Please check all fields have been filled out")
            return
        }
        continueLoginFlow(email: email, password: password)
    }
    @IBAction func bottomButtonPressed(_ sender: RoundedCornerButton) {
        if accountState == .existingUser {
            accountState = .newUser
        } else {
            accountState = .existingUser
        }
        configureLoginButtons()
    }
    
}

//MARK:- Extensions
extension LoginViewControllerRefactor: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
