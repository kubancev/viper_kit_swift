//
//  UIViewController+Swizzling.m
//  ViperKit
//
//  Created by Bradbury Lab on 28.12.2017.
//  Copyright © 2017 Bradbury Lab. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "ModuleInput.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzling)

+ (instancetype)alloc {
    UIViewController* allocated = [super alloc];
    if (allocated) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class class = object_getClass(allocated);
            
            SEL originalSelector = @selector(prepareForSegue:sender:);
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            IMP swizzledImplementation = (IMP)viperKit_PrepareForSegueSender;
            
            method_setImplementation(originalMethod, swizzledImplementation);
        });
    }
    return allocated;
}

-(id<ModuleInput>)moduleInput {
    id<ModuleInput> moduleInput = (id<ModuleInput>)objc_getAssociatedObject(self, @selector(moduleInput));
    if (!moduleInput) {
        self.moduleInput = objc_getAssociatedObject(self, "delegate");
    }
    return moduleInput;
}

-(void)setModuleInput:(id<ModuleInput>)moduleInput {
    objc_setAssociatedObject(self, @selector(moduleInput), moduleInput, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

void viperKit_PrepareForSegueSender(id self, SEL selector, UIStoryboardSegue * segue, id sender) {
    UIViewController* destinationViewController = segue.destinationViewController;
    if ([destinationViewController isKindOfClass:UINavigationController.class]) {
        destinationViewController = [((UINavigationController*)destinationViewController) topViewController];
    }
    id<ModuleInput> destinationModuleInput = destinationViewController.moduleInput;
    ConfigurationBlock block = (ConfigurationBlock)sender;
    if (destinationViewController && destinationModuleInput && block) {
        block(destinationModuleInput);
    }
}

@end
