//
//  AboutViewController.m
//  IMLite
//
//  Created by sang alfred on 2/9/14.
//  Copyright (c) 2014 18842685026@163.com. All rights reserved.
//

#import "AboutUserProtocalViewController.h"

@interface AboutUserProtocalViewController ()
@property(weak, nonatomic) IBOutlet UITextView *TextView;

@end

@implementation AboutUserProtocalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"用户协议"];
    }
    return self;
}

- (void)viewDidLoadt {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.TextView.backgroundColor = APPBACKCOLOR;
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
