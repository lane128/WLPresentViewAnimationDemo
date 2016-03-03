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
#import "PushViewContrller.h"

static NSTimeInterval const kDuration = 1.0f;

@interface WLControllerTransition ()

@property (nonatomic, assign) WLTransitionType type;
@property (nonatomic, assign) NSTimeInterval duratioin;

@end

@implementation WLControllerTransition

+ (WLControllerTransition *)transitionWithType:(WLTransitionType)type duration:(NSTimeInterval)duration {
    WLControllerTransition *transition = [[WLControllerTransition alloc] init];
    transition.type = type;
    transition.duratioin = duration > 0 ? duration : kDuration;
    transition.delay = 0.0;
    transition.usingSpringWithDamping = 1.0f;
    transition.initialSpringVelocity = 0.0;
    transition.options = UIViewAnimationOptionTransitionNone;
    transition.animationEndStatus = nil;
    transition.animationStartStatus = nil;
    transition.animationCompletionStatus = nil;
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
    if (self.animationStartStatus) {
        self.animationStartStatus(transitionContext);
    }
    [UIView animateWithDuration:self.duratioin
                          delay:self.delay
         usingSpringWithDamping:self.usingSpringWithDamping
          initialSpringVelocity:self.initialSpringVelocity
                        options:self.options
                     animations:^{
                         if (self.animationEndStatus) {
                             self.animationEndStatus(transitionContext);
                         }
                     } completion:^(BOOL finished) {
                         if (finished) {
                             if (self.animationCompletionStatus) {
                                 self.animationCompletionStatus(transitionContext);
                             }
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

- (void)dismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.animationStartStatus) {
        self.animationStartStatus(transitionContext);
    }
    [UIView animateWithDuration:self.duratioin
                          delay:self.delay
         usingSpringWithDamping:self.usingSpringWithDamping
          initialSpringVelocity:self.initialSpringVelocity
                        options:self.options
                     animations:^{
                         if (self.animationEndStatus) {
                             self.animationEndStatus(transitionContext);
                         }
                     } completion:^(BOOL finished) {
                         if (finished) {
                             if (self.animationCompletionStatus) {
                                 self.animationCompletionStatus(transitionContext);
                             }
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

- (void)pushTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.animationStartStatus) {
        self.animationStartStatus(transitionContext);
    }
    [UIView animateWithDuration:self.duratioin
                          delay:self.delay
         usingSpringWithDamping:self.usingSpringWithDamping
          initialSpringVelocity:self.initialSpringVelocity
                        options:self.options
                     animations:^{
                         if (self.animationEndStatus) {
                             self.animationEndStatus(transitionContext);
                         }
                     } completion:^(BOOL finished) {
                         if (finished) {
                             if (self.animationCompletionStatus) {
                                 self.animationCompletionStatus(transitionContext);
                             }
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

- (void)popTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}

@end
