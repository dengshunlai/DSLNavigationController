//
//  SgViewController.m
//  DSLNavigationController
//
//  Created by 邓顺来 on 16/8/7.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "SgViewController.h"
#import "UIViewController+DSLNavigationBar.h"

@interface SgViewController ()

@end

@implementation SgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISegmentedControl *sg = self.dsl_navigationBar.titleSegment;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
