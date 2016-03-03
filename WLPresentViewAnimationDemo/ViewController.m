//
//  ViewController.m
//  WLPresentViewAnimationDemo
//
//  Created by Lane on 16/3/2.
//  Copyright © 2016年 lane128. All rights reserved.
//

#import "ViewController.h"
#import "PlayViewController.h"
#import "PushViewContrller.h"
#import "WLControllerTransition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.presentView];
    [self.view addSubview:self.pushButton];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentTranstion)];
    [self.presentView addGestureRecognizer:tapGesture];
}

- (UIView *)presentView {
    if (!_presentView) {
        _presentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kWidth, 300)];
        _presentView.backgroundColor = [UIColor grayColor];
    }
    return _presentView;
}

- (UIButton *)pushButton {
    if (!_pushButton) {
        _pushButton = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 2 - 50, 350, 100, 30)];
        [_pushButton setTitle:@"Push" forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(pushTransition) forControlEvents:UIControlEventTouchUpInside];
        _pushButton.layer.borderColor = [UIColor blackColor].CGColor;
        _pushButton.layer.borderWidth = 1.0f;
        [_pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _pushButton;
}

- (void)presentTranstion {
    NSLog(@"transtionAnimation");
    PlayViewController *playCV = [[PlayViewController alloc] init];
    [self presentViewController:playCV animated:YES completion:nil];
}

- (void)pushTransition {
    NSLog(@"pushTransition");
    PushViewContrller *pushVC = [[PushViewContrller alloc] init];
    self.navigationController.delegate = pushVC;
    [self.navigationController pushViewController:pushVC animated:YES];
}

@end
