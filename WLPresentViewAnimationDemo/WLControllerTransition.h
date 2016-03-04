//
//  WLControllerTransition.h
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//for furture work
typedef NS_ENUM(NSUInteger, WLTransitionType) {
    kWLTransitionPresent = 1 << 1,
    kWLTransitionDismiss = 1 << 2,
    kWLTransitionPush = 1 << 3,
    kWLTransitionPop = 1 << 4
};

typedef void (^animationStartStatusBlock)(id<UIViewControllerContextTransitioning> transitionContext);
typedef void (^animationEndStatusBlock)(id<UIViewControllerContextTransitioning> transitionContext);
typedef void (^animationCompletionStatusBlock)(id<UIViewControllerContextTransitioning> transitionContext);

@interface WLControllerTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, assign) CGFloat usingSpringWithDamping;
@property (nonatomic, assign) CGFloat initialSpringVelocity;
@property (nonatomic, assign) UIViewAnimationOptions options;
@property (nonatomic, copy) animationStartStatusBlock animationStartStatus;
@property (nonatomic, copy) animationEndStatusBlock animationEndStatus;
@property (nonatomic, copy) animationCompletionStatusBlock animationCompletionStatus;

+ (WLControllerTransition *)transitionWithType:(WLTransitionType)type duration:(NSTimeInterval)duration;

- (void)setAnimationStartStatus:(animationStartStatusBlock)block;

- (void)setAnimationEndStatus:(animationEndStatusBlock)block;

- (void)setAnimationCompletionStatus:(animationCompletionStatusBlock)block;

@end
