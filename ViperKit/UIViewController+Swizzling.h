//
//  UIViewController+Swizzling.h
//  ViperKit
//
//  Created by Bradbury Lab on 28.12.2017.
//  Copyright © 2017 Bradbury Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleInput.h"

typedef void (^ConfigurationBlock)(id<ModuleInput> _Nullable moduleInput);

@interface UIViewController (Swizzling)
@property (nonatomic, strong) id<ModuleInput>_Nullable moduleInput;

@end
