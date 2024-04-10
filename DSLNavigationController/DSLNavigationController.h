//
//  DSLNavigationController.h
//  DSLNavigationControllerDemo
//
//  Created by dengshunlai on 16/6/2.
//  Copyright © 2016年 dengshunlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSLNavigationController : UINavigationController

/**
 *  转场类型，默认为0，可以在实现文件中定义自己的转场类型，1为模拟系统原生转场动画
 */
@property (nonatomic, assign) IBInspectable NSInteger type;

/**
 *  指定初始化方法
 *
 *  @param rootViewController 根视图控制器
 *  @param type               转场类型，默认为0
 *
 *  @return DSLNavigationController实例
 */
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController type:(NSInteger)type;

@end


@interface DSLInteractiveAnimator : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

- (instancetype)initWithNavc:(DSLNavigationController *)navc;

@end
