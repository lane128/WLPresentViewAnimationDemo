//
//  PlayViewController.m
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#import "PlayViewController.h"
#import "WLControllerTransition.h"

@interface PlayViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation PlayViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defineLayout];
    [self addTapGesture];
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
}

- (void)defineLayout {
    self.view.frame = CGRectMake(0, 0, kWidth, kHeight);
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    [self.view addGestureRecognizer:tap];
}

- (void)closeView {
    NSLog(@"closeView");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [WLControllerTransition transitionWithType:kWLTransitionPresent duration:1.0f];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [WLControllerTransition transitionWithType:kWLTransitionDismiss duration:1.0f];
}

@end
