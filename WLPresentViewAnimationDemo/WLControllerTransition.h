//
//  WLControllerTransition.h
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WLTransitionType) {
    kWLTransitionPresent = 1 << 1,
    kWLTransitionDismiss = 1 << 2,
    kWLTransitionPush = 1 << 3,
    kWLTransitionPop = 1 << 4
};

@interface WLControllerTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, assign) CGFloat usingSpringWithDamping;
@property (nonatomic, assign) CGFloat initialSpringVelocity;
@property (nonatomic, assign) UIViewAnimationOptions options;
@property (nonatomic, copy) void (^animationStartStatus)(id<UIViewControllerContextTransitioning> transitionContext);
@property (nonatomic, copy) void (^animationEndStatus)(id<UIViewControllerContextTransitioning> transitionContext);
@property (nonatomic, copy) void (^animationCompletionStatus)(id<UIViewControllerContextTransitioning> transitionContext);

+ (WLControllerTransition *)transitionWithType:(WLTransitionType)type duration:(NSTimeInterval)duration;

@end
