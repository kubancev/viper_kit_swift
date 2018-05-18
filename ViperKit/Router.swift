//
//  Router.swift
//  ViperKit
//
//  Created by Rizer on 18.05.2018.
//  Copyright © 2018 Rizer. All rights reserved.
//

public class Router {
  weak var transitionHandler: (TransitionHandler & UIViewController)?

	public func openModule(_ segueIdentifier: String) {
        transitionHandler?.openModule(segueIdentifier)
    }
    
    public func openModule(_ segueIdentifier: String, configurationBlock: @convention(block) (ModuleInput?) -> ()) {
	    transitionHandler?.openModule(segueIdentifier, configurationBlock: configurationBlock)
    }
    
    public func closeCurrentModule(animated: Bool) {
        transitionHandler?.closeCurrentModule(animated: animated)
    }
}
