//
//  TransitionHandler.swift
//  ViperKit
//
//  Created by Ruslan Bolataev on 11/03/2017.
//  Copyright © 2017 Rizer. All rights reserved.
//

public protocol TransitionHandler: class {
    func openModule(_ segueIdentifier: String)
    func openModule(_ segueIdentifier: String, configurationBlock: @convention(block) (ModuleInput?) -> ())
    func closeCurrentModule(animated: Bool, completionHandler: (() -> Void)?)
    func presentModally(with viewController: UIViewController, animated: Bool, completionHandler: (() -> Void)?)
    func push(_ viewController: UIViewController, animated: Bool, completionHandler: (() -> Void)?)
}

