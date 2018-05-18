//
//  UIViewController+Swizzling.h
//  ViperKit
//
//  Created by Rizer on 28.12.2017.
//  Copyright © 2017 Rizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleInput.h"

typedef void (^ConfigurationBlock)(id<ModuleInput> _Nullable moduleInput);

@interface UIViewController (Swizzling)
@property (nonatomic, strong, readonly) NSString*_Nonnull tokenId;
@property (nonatomic, strong) id<ModuleInput>_Nullable moduleInput;

@end
