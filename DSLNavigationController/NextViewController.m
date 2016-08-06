//
//  NextViewController.m
//  DSLNavigationController
//
//  Created by 邓顺来 on 16/8/6.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+DSLNavigationBar.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(UIButton *)sender {
    self.dsl_navigationBar.showActivityIndicator = YES;
}

- (IBAction)hide:(UIButton *)sender {
    self.dsl_navigationBar.showActivityIndicator = NO;
}

- (IBAction)changeNavigationBarAlpha:(UISlider *)sender {
    self.dsl_navigationBar.bgAlpha = sender.value;
}

@end
