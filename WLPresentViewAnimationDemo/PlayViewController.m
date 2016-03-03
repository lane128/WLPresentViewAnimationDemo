//
//  PlayViewController.m
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

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
    WLControllerTransition *transition = [WLControllerTransition transitionWithType:kWLTransitionPresent duration:1.5f];
    transition.options = UIViewAnimationOptionCurveEaseIn;
    transition.animationStartStatus = ^(id<UIViewControllerContextTransitioning> transitionContext) {
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *containerView = [transitionContext containerView];
        
        UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        fromVC.view.hidden = YES;
        UIView *toView = toVC.view;
        [containerView addSubview:tempView];
        [containerView addSubview:toView];
        toView.frame = CGRectMake(0, 0, 0, 0);
        toView.alpha = 0.0;
    };
    
    transition.animationEndStatus = ^(id<UIViewControllerContextTransitioning> transitionContext){
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *containerView = [transitionContext containerView];
        UIView *toView = toVC.view;
        toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        toView.transform = CGAffineTransformMakeRotation(M_PI);
        toView.alpha = 1.0f;
    };
    
    return transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    WLControllerTransition *transition = [WLControllerTransition transitionWithType:kWLTransitionDismiss duration:1.5f];
    transition.animationEndStatus = ^(id<UIViewControllerContextTransitioning> transitionContext) {
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        fromVC.view.frame = CGRectMake(0, 0, 0, 0);
        fromVC.view.transform = CGAffineTransformIdentity;
    };
    transition.animationCompletionStatus = ^(id<UIViewControllerContextTransitioning> transitionContext) {
        UIView *containerView = [transitionContext containerView];
        UIView *tempView = containerView.subviews.lastObject;
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.hidden = NO;
        [tempView removeFromSuperview];
    };
    return transition;
}

@end
