//
//  DSLNavigationBar.h
//  videoForHearthstone
//
//  Created by 邓顺来 on 16/5/15.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface DSLNavigationBar : UIView

/**
 *  title
 */
@property (nonatomic, strong) IBInspectable NSString *title;

/**
 *  title的字体大小，默认20
 */
@property (nonatomic, assign) IBInspectable CGFloat fontSizt;

/**
 *  title字体颜色，默认0x333333
 */
@property (nonatomic, strong) IBInspectable UIColor *titleColor;

/**
 *  返回按钮的frame，默认(0,20,44,44)
 */
@property (assign, nonatomic) IBInspectable CGRect backFrame;

/**
 *  返回按钮normal状态下的image
 */
@property (nonatomic, strong) IBInspectable UIImage *normalImage;

/**
 *  返回按钮highlight状态下的image
 */
@property (nonatomic, strong) IBInspectable UIImage *highlightImage;

/**
 *  是否隐藏返回按钮，默认NO
 */
@property (nonatomic, assign) IBInspectable BOOL hideBack;

/**
 *  title Lable
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/**
 *  返回按钮
 */
@property (nonatomic, strong, readonly) UIButton *backBtn;

/**
 *  是否展示活动指示器
 */
@property (assign, nonatomic) BOOL showActivityIndicator;

/**
 *  活动指示器风格，默认UIActivityIndicatorViewStyleGray
 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorStyle;

/**
 *  返回按钮点击回调，默认为pop
 */
@property (copy, nonatomic) void (^backBtnClickBlock)(void);

/**
 *  背景透明度
 */
@property (assign, nonatomic) CGFloat bgAlpha;

@end
