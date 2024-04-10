//
//  BtnViewController.m
//  DSLNavigationController
//
//  Created by 邓顺来 on 16/8/7.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "BtnViewController.h"
#import "UIViewController+DSLNavigationBar.h"
#import "CodeViewController.h"

@interface BtnViewController ()

@end

@implementation BtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *titleBtn = self.dsl_navigationBar.titleButton;
    [titleBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click:(UIButton *)sender
{
    if (sender.tag == 0) {
        self.dsl_navigationBar.showActivityIndicator = YES;
        sender.tag = 1;
    } else {
        self.dsl_navigationBar.showActivityIndicator = NO;
        sender.tag = 0;
    }
}

- (IBAction)clickBtn:(UIButton *)sender {
    CodeViewController *vc = [[CodeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
