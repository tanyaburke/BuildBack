//
//  InitialViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
///Plays a Giff that matches the initial imamge on the LaunchScreen
class GifIntroViewController: UIViewController {
    
    //MARK:- Variables/Constants
    let logoAnimationView = GifIntroView()
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadGifAnimation()
    }
    override func loadView() {
        view = logoAnimationView
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- Functions
    private func loadGifAnimation() {
        let animationTime = 4.2
        DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = (scene?.delegate as? SceneDelegate) {
                UIView.transition(with: self.logoAnimationView,
                                  duration: 3.0,
                                  options: .transitionCrossDissolve,
                                  animations: nil,
                                  completion: nil)
                sceneDelegate.afterSplashScreenAnimation()
            }
        }
    }
    
}
