//
//  UIViewController+Swizzling.m
//  ViperKit
//
//  Created by Rizer on 28.12.2017.
//  Copyright © 2017 Rizer. All rights reserved.
//

#define moduleInputAssociatedObjectKey "~"

#import "UIViewController+Swizzling.h"
#import "ModuleInput.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzling)

+(instancetype)alloc {
    UIViewController* allocated = [super alloc];
    if (allocated) {
        Class class = object_getClass(allocated);
        
        SEL originalSelector = @selector(prepareForSegue:sender:);
        SEL swizzledSelector = @selector(viperKit_PrepareForSegue:sender:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }
    }
    return allocated;
}

-(NSString *)tokenId {
    return @"UIViewController.prepareForSegue";
}

-(id<ModuleInput>)moduleInput {
    id<ModuleInput> moduleInput = (id<ModuleInput>)objc_getAssociatedObject(self, moduleInputAssociatedObjectKey);
    if (!moduleInput) {
        self.moduleInput = objc_getAssociatedObject(self, "delegate");
    }
    return moduleInput;
}

-(void)setModuleInput:(id<ModuleInput>)moduleInput {
    objc_setAssociatedObject(self, moduleInputAssociatedObjectKey, moduleInput, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)viperKit_PrepareForSegue:(UIStoryboardSegue*)segue
                         sender:(id)sender {
    
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
