//
//  UIViewController+Ext.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /*
     * Presents custom alert on main thread - MSAlertViewController
     * Parameters: title, message, dismissButtonTitle, confirmButtonTitle
     */
    func presentMSAlertOnMainThread(title: String, message: String, dismissButtonTitle: String, confirmButtonTitle: String) {
            DispatchQueue.main.async {
                let alertViewController = MSAlertViewController(title: title, message: message, dismissButtonTitle: dismissButtonTitle, confirmButtonTitle: confirmButtonTitle)
                alertViewController.modalPresentationStyle = .overFullScreen
                alertViewController.modalTransitionStyle = .crossDissolve
                self.present(alertViewController, animated: true)
            }
        }
    
    
    
}
