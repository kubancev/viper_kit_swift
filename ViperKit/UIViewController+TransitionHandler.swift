//
//  UIViewController+TransitionHandler.swift
//  ViperKit
//
//  Created by Ruslan Bolataev on 11/03/2017.
//  Copyright © 2017 Rizer. All rights reserved.
//

import UIKit

extension UIViewController: TransitionHandler {
    public func openModule(_ segueIdentifier: String) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    public func openModule(_ segueIdentifier: String, configurationBlock: @convention(block) (ModuleInput?) -> ()) {
        performSegue(withIdentifier: segueIdentifier, sender: configurationBlock)
    }
    
    public func closeCurrentModule(animated: Bool) {
        let isInNavigationStack = parent is UINavigationController
        let hasManyControllersInStack = isInNavigationStack
            ? (parent as! UINavigationController).childViewControllers.count > 1
            : false
        
        if isInNavigationStack && hasManyControllersInStack {
            let navigationController = parent as! UINavigationController
            navigationController.popViewController(animated: animated)
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
        } else if view.superview != nil {
            removeFromParentViewController()
            view.removeFromSuperview()
        }
    }
}

