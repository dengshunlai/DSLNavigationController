//
//  NextViewController.m
//  DSLNavigationController
//
//  Created by 邓顺来 on 16/8/6.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+DSLNavigationBar.h"
#import "DSLNavigationController.h"
#import "BtnViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dsl_navigationBar.bgAlpha = 0;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //恢复原来的转场动画
    DSLNavigationController *nc = (DSLNavigationController *)self.navigationController;
    nc.type = 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //改变转场动画
    DSLNavigationController *nc = (DSLNavigationController *)self.navigationController;
    if ([segue.destinationViewController isKindOfClass:[BtnViewController class]]) {
        nc.type = 1;
    } else {
        nc.type = 2;
    }
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
