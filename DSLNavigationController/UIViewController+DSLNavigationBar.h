//
//  UIViewController+DSLNavigationBar.h
//  DSLNavigationController
//
//  Created by 邓顺来 on 16/8/6.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLNavigationBar.h"

@interface UIViewController (DSLNavigationBar)

/**
 *  获取该视图控制器中的DSLNavigationBar
 */
@property (weak, nonatomic) DSLNavigationBar *dsl_navigationBar;

- (void)dsl_setupNavigationBar;

@end
