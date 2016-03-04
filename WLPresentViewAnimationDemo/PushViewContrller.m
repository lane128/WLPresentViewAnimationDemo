//
//  PushViewContrller.m
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/3.
//  Copyright © 2016年 lane128. All rights reserved.
//

#import "PushViewContrller.h"
#import "WLControllerTransition.h"

@interface PushViewContrller () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *contextView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation PushViewContrller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self.view addSubview:self.contextView];
    [self.contextView addSubview:self.backButton];
}

- (UIView *)contextView {
    if (!_contextView) {
        _contextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _contextView.backgroundColor = [UIColor yellowColor];
    }
    return _contextView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 100, 30)];
        [_backButton setTitle:@"back" forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backTransition) forControlEvents:UIControlEventTouchUpInside];
        _backButton.layer.borderColor = [UIColor blackColor].CGColor;
        _backButton.layer.borderWidth = 1.0f;
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _backButton;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        WLControllerTransition *transition = [WLControllerTransition transitionWithType:kWLTransitionPush duration:1.5f];
        [transition setAnimationStartStatus:^(id<UIViewControllerContextTransitioning> transitionContext) {
            UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            UIView *containerView = [transitionContext containerView];
            [containerView addSubview:fromVC.view];
            [containerView addSubview:toVC.view];
            toVC.view.frame = CGRectMake(kWidth, -kHeight, kWidth, kHeight);
            toVC.view.alpha = 0.0;
        }];
        
        [transition setAnimationEndStatus:^(id<UIViewControllerContextTransitioning> transitionContext) {
            UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            toVC.view.alpha = 1.0;
            toVC.view.frame = CGRectMake(0, 0, kWidth, kHeight);
        }];
        return transition;
    } else if (operation == UINavigationControllerOperationPop) {
        return nil;//默认pop动画
    } else {
        return nil;
    }
}

- (void)backTransition {
    NSLog(@"backTransition");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
