//
//  DrawerDetailViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 8/27/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit


    /// Subscribe to this object if you would like to receive notifications about the status of the pan gesture recognizer.
    protocol DrawerDetailViewControllerDelegate: AnyObject {
        
        /// Called when a pan gesture has begun.
        /// - Parameter cardViewController: `CardPresentationController` displays detils about an attraction.
        func panGestureDidBegin(_ cardViewController: DrawerDetailViewController)
        
        /// Called when a pan gesture has changed
        /// - Parameters:
        ///   - cardViewController: `CardPresentationController` displays detils about an attraction.
        ///   - translation: The translation of the pan gesture in the coordinate system of the specified view.
        func panGestureDidChange(_ cardViewController: DrawerDetailViewController, with translation: CGPoint)
        
        /// Called when a pan gesture has ended
        /// - Parameter cardViewController: `CardPresentationController` displays detils about an attraction.
        func panGestureDidEnd(_ cardViewController: DrawerDetailViewController)
    }

    final class DrawerDetailViewController: UIViewController {
        
        @IBOutlet private weak var handleAreaView: UIView!
        
        private lazy var panGestureRecognizer: UIPanGestureRecognizer = .init(target: self, action: #selector(handleCardPan(panGestureRecognizer:)))
        
        weak var delegate: DrawerDetailViewControllerDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            handleAreaView.isUserInteractionEnabled = true
            handleAreaView.addGestureRecognizer(panGestureRecognizer)
        }
        
        @objc private func handleCardPan(panGestureRecognizer: UIPanGestureRecognizer) {
            switch panGestureRecognizer.state {
            case .began:
                delegate?.panGestureDidBegin(self)
            case .changed:
                delegate?.panGestureDidChange(self, with: panGestureRecognizer.translation(in: handleAreaView))
            case .ended:
                delegate?.panGestureDidEnd(self)
            default:
                break
            }
        }
    }
