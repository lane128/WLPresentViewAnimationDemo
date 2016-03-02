//
//  ViewController.m
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "UIViewController+ShowModalFromView.h"
#import "PlayViewController.h"
#import "WLControllerTransition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.presentView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transtionAnimation)];
    [self.presentView addGestureRecognizer:tapGesture];
}

- (UIView *)presentView {
    if (!_presentView) {
        _presentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, 300)];
        _presentView.backgroundColor = [UIColor grayColor];
    }
    return _presentView;
}

- (void)transtionAnimation {
    NSLog(@"transtionAnimation");
    PlayViewController *playCV = [[PlayViewController alloc] init];
    [self presentViewController:playCV animated:YES completion:nil];
}

@end
