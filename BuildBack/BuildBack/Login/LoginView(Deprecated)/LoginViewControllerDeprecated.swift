//
//  LoginViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import FirebaseAuth


//enum AccountState {
//    case existingUser
//    case newUser
//}

class LoginViewControllerDeprecated: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var signInOrUpLabel: UILabel!
    @IBOutlet weak var signInUpButton: UIButton!
    @IBOutlet weak var appleLoginButton: RoundedCornerButton!
    
    @IBOutlet weak var nameTextField: UnderlinedTextfield!
    @IBOutlet weak var emailTextField: UnderlinedTextfield!
    @IBOutlet weak var passwordTextField: UnderlinedTextfield!
    
    //MARK:- Variables/ Constants
    private var accountState: AccountState?
    private var authSession = AuthenticationSession()
    
    let dataBaseService = DatabaseService()
    
    //MARK:- Initializers
    init?(coder: NSCoder, accountState: AccountState) {
        self.accountState = accountState
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Functions
    private func setupUI() {
//        nameTextField.delegate = self
//        emailTextField.delegate = self
//        passwordTextField.delegate = self
//        appleLoginButton.titleLabel?.adjustsFontSizeToFitWidth = true
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
    
    //MARK:- @IBActions
    @IBAction func signInUpButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else {
            print("missing fields")
            return
        }
        continueLoginFlow(email: email, password: password)
    }
    
}


//MARK:- Extensions
extension LoginViewControllerDeprecated: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
