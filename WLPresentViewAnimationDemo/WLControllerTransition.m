//
//  WLControllerTransition.m
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#import "WLControllerTransition.h"
#import "ViewController.h"
#import "PlayViewController.h"

@interface WLControllerTransition ()

@property (nonatomic, assign) WLModalTransitionType type;
@property (nonatomic, assign) NSTimeInterval duratioin;

@end

@implementation WLControllerTransition

+ (WLControllerTransition *)transitionWithType:(WLModalTransitionType)type duration:(NSTimeInterval)duration {
    WLControllerTransition *transition = [[WLControllerTransition alloc] init];
    transition.type = type;
    transition.duratioin = duration;
    return transition;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.type == kWLModalTransitionPresent) {
        [self presentTransition:transitionContext];
    }
    if (self.type == kWLBModalTransitionDismiss) {
        [self dismissTransition:transitionContext];
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

@end
