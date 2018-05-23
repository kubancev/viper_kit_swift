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
    
    public func closeCurrentModule(animated: Bool, completionHandler: (() -> Void)?) {
        let isInNavigationStack = parent is UINavigationController
        let hasManyControllersInStack = isInNavigationStack
            ? (parent as! UINavigationController).childViewControllers.count > 1
            : false
        
        if isInNavigationStack && hasManyControllersInStack {
            let navigationController = parent as! UINavigationController
            navigationController.popViewController(animated: animated, completion: completionHandler)
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: completionHandler)
        } else if view.superview != nil {
            removeFromParentViewController()
            view.removeFromSuperview()
            completionHandler?()
        }
    }
    
    public func presentModally(with viewController: UIViewController, animated: Bool, completionHandler: (() -> Void)?) {
        present(viewController, animated: animated, completion: completionHandler)
    }
    
    public func push(_ viewController: UIViewController, animated: Bool, completionHandler: (() -> Void)?) {
        navigationController?.pushViewController(viewController, animated: animated, completion: completionHandler)
    }
}

extension UINavigationController {
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion?()
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
    
    public func popViewController(animated: Bool, completion: (() -> Void)?) {
        popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion?()
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}
