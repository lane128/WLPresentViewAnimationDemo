//
//  WLControllerTransition.h
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WLModalTransitionType) {
    kWLModalTransitionPresent = 1 << 1,
    kWLBModalTransitionDismiss = 1 << 2
};

@interface WLControllerTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (WLControllerTransition *)transitionWithType:(WLModalTransitionType)type duration:(NSTimeInterval)duration;

@end
