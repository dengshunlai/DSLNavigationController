//
//  CodeViewController.m
//  DSLNavigationController
//
//  Created by 邓顺来1992 on 2024/4/10.
//  Copyright © 2024 邓顺来. All rights reserved.
//

#import "CodeViewController.h"
#import "UIViewController+DSLNavigationBar.h"

@interface CodeViewController ()

@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self dsl_setupNavigationBar];
}

@end
