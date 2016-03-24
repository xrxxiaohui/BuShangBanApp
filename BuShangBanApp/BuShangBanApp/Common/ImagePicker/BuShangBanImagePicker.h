//
//  BuShangBanImagePicker.h
//  Youqun
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ImagePickerFinishAction)(UIImage *image);

@interface BuShangBanImagePicker : NSObject

+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(ImagePickerFinishAction)finishAction;
@end
