//
//  WLControllerTransition.m
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#import "WLControllerTransition.h"
#import "ViewController.h"
#import "PlayViewController.h"
#import "PushViewContrller.h"

@interface WLControllerTransition ()

@property (nonatomic, assign) WLTransitionType type;
@property (nonatomic, assign) NSTimeInterval duratioin;

@end

@implementation WLControllerTransition

+ (WLControllerTransition *)transitionWithType:(WLTransitionType)type duration:(NSTimeInterval)duration {
    WLControllerTransition *transition = [[WLControllerTransition alloc] init];
    transition.type = type;
    transition.duratioin = duration;
    return transition;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case kWLTransitionPresent:
            [self presentTransition:transitionContext];
            break;
        
        case kWLTransitionDismiss:
            [self dismissTransition:transitionContext];
            break;
            
        case kWLTransitionPush:
            [self pushTransition:transitionContext];
            break;
            
        case kWLTransitionPop:
            [self popTransition:transitionContext];
            break;
            
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duratioin;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Private

- (void)presentTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PlayViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromVC.view.hidden = YES;
    UIView *toView = toVC.view;
    
    [containerView addSubview:tempView];
    [containerView addSubview:toView];
    
    toView.frame = CGRectMake(0, 0, 0, 0);
    toView.alpha = 0.0;
    
    [UIView animateWithDuration:self.duratioin animations:^{
        toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        toView.transform = CGAffineTransformMakeRotation(M_PI);
        toView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        if (finished) {
           [transitionContext completeTransition:YES];
        }
    }];
}

- (void)dismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    PlayViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempView = containerView.subviews.lastObject;
    
    [UIView animateWithDuration:self.duratioin animations:^{
        fromVC.view.frame = CGRectMake(0, 0, 0, 0);
        fromVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

- (void)pushTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PushViewContrller *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(kWidth, -kHeight, kWidth, kHeight);
    toVC.view.alpha = 0.0;
    
    [UIView animateWithDuration:self.duratioin animations:^{
        toVC.view.alpha = 1.0;
        toVC.view.frame = CGRectMake(0, 0, kWidth, kHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
        }
    }];
}

- (void)popTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}

@end
