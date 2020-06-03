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
    
    private var accountState: AccountState = .existingUser
    
    private var authSession = AuthenticationSession()
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func signInUpButton(_ sender: UIButton) {

        UIViewController.showViewController(storyBoardName: "MainView", viewControllerId: "TabBarViewController")
        
        //        guard let email = emailTextFeild.text,
//               !email.isEmpty,
//               let password = passWordTextFeild.text,
//               !password.isEmpty else {
//                 print("missing fields")
//                 return
//             }
//             continueLoginFlow(email: email, password: password)
         }
         
    private func continueLoginFlow(email: String, password: String) {
//           if accountState == .existingUser {
//             authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
//               switch result {
//               case .failure(let error):
//                 DispatchQueue.main.async {
//                   self?.errorLabel.text = "\(error.localizedDescription)"
//                   self?.errorLabel.textColor = .systemRed
//                 }
//               case .success:
//                 DispatchQueue.main.async {
//                   self?.navigateToMainView()
//                 }
//               }
//             }
//           } else {
//             authSession.createNewUser(email: email, password: password) { [weak self] (result) in
//               switch result {
//               case .failure(let error):
//                 DispatchQueue.main.async {
//                   self?.errorLabel.text = "\(error.localizedDescription)"
//                   self?.errorLabel.textColor = .systemRed
//                 }
//               case .success:
//                 DispatchQueue.main.async {
//                   self?.navigateToMainView()
//                 }
//               }
//             }
//           }
         }
        
        
    
    
  

}
