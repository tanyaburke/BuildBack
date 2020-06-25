//
//  InitialViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
        
                let logoAnimationView = InitialView()
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    
                    view.backgroundColor = .systemBackground
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                  
                        
                        let scene = UIApplication.shared.connectedScenes.first
                        if let sceneDelegate = (scene?.delegate as? SceneDelegate) {
                            UIView.transition(with: self.logoAnimationView,
                                              duration: 2.0,
                                                       options: .transitionCrossDissolve,
                                                       animations: nil,
                                                       completion: nil)
                            sceneDelegate.afterSplashScreenAnimation()
                        }
                    }
                 
                }

                
                override func loadView() {
                    view = logoAnimationView
                }
                
                override func viewDidAppear(_ animated: Bool) {
                    super.viewDidAppear(animated)
                }
                
            }
