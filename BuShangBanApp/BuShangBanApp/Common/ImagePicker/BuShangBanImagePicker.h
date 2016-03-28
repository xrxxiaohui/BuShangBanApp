//
//  BuShangBanImagePicker.h


#import <Foundation/Foundation.h>


typedef void (^ImagePickerFinishAction)(UIImage *image);

@interface BuShangBanImagePicker : NSObject

+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(ImagePickerFinishAction)finishAction;
@end
