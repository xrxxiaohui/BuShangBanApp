//
//  BuShangBanImagePicker.m

#import "BuShangBanImagePicker.h"
#import <UIKit/UIKit.h>


@interface BuShangBanImagePicker () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, weak) UIViewController *viewController;
@property(nonatomic, copy) ImagePickerFinishAction finishAction;
@property(nonatomic, assign) BOOL allowsEditing;
@end

static BuShangBanImagePicker *imagePickerInstance = nil;

@implementation BuShangBanImagePicker

+ (void)showImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(ImagePickerFinishAction)finishAction {
    if (imagePickerInstance == nil) {
        imagePickerInstance = [[BuShangBanImagePicker alloc] init];
    }
    [imagePickerInstance showImagePickerFromViewController:viewController
                                             allowsEditing:allowsEditing
                                              finishAction:finishAction];
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(ImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditing;

    UIActionSheet *sheet = nil;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                   cancelButtonTitle:@"取消" destructiveButtonTitle:nil
                                   otherButtonTitles:@"拍照", @"从相册选择", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"从相册选择", nil];
    }

    UIView *window = [UIApplication sharedApplication].keyWindow;
    [sheet showInView:window];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([title isEqualToString:@"拍照"]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = _allowsEditing;
        [_viewController presentViewController:picker animated:YES completion:nil];
    } else if ([title isEqualToString:@"从相册选择"]) {
        picker.allowsEditing = YES;
        [_viewController presentViewController:picker animated:YES completion:nil];
    } else {
        imagePickerInstance = nil;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil)
        image = info[UIImagePickerControllerOriginalImage];
    if (_finishAction)
        _finishAction(image);
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    imagePickerInstance = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (_finishAction)
        _finishAction([UIImage imageNamed:@"defaultHead"]);
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    imagePickerInstance = nil;
}

@end
