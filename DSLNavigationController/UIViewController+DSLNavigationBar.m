//
//  UIViewController+DSLNavigationBar.m
//  DSLNavigationController
//
//  Created by 邓顺来 on 16/8/6.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "UIViewController+DSLNavigationBar.h"
#import <objc/runtime.h>

@implementation UIViewController (DSLNavigationBar)

- (DSLNavigationBar *)dsl_navigationBar
{
    DSLNavigationBar *topbar = objc_getAssociatedObject(self, @selector(dsl_navigationBar));
    if (!topbar) {
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[DSLNavigationBar class]]) {
                topbar = self.dsl_navigationBar = (DSLNavigationBar *)view;
            }
        }
    }
    return topbar;
}

- (void)setDsl_navigationBar:(DSLNavigationBar *)dsl_navigationBar
{
    objc_setAssociatedObject(self, @selector(dsl_navigationBar), dsl_navigationBar, OBJC_ASSOCIATION_ASSIGN);
}

- (void)dsl_setupNavigationBar {
    DSLNavigationBar *topbar = [[DSLNavigationBar alloc] init];
    self.dsl_navigationBar = topbar;
    [self.view addSubview:topbar];
    topbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topbar]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topbar)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:topbar attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
}

@end
