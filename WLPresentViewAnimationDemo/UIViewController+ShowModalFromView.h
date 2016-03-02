//
//  UIViewController+ShowModalFromView.h
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShowModalFromView)

- (void)presentModalViewController:(UIViewController *)modalViewController
                          fromView:(UIView *)view
                        completion:(void (^)(void))completion;

@end
