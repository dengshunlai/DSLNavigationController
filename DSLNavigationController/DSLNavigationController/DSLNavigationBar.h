//
//  DSLNavigationBar.h
//  videoForHearthstone
//
//  Created by 邓顺来 on 16/5/15.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DSLNavigationBarTitleStyle) {
    DSLNavigationBarTitleStyleLable = 0,
    DSLNavigationBarTitleStyleSegment,
    DSLNavigationBarTitleStyleButton
};

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
 *  返回按钮
 */
@property (nonatomic, strong, readonly) UIButton *backBtn;

/**
 *  返回按钮点击回调，默认为pop
 */
@property (copy, nonatomic) void (^backBtnClickBlock)(void);

/**
 *  是否展示活动指示器，默认NO
 */
@property (assign, nonatomic) BOOL showActivityIndicator;

/**
 *  活动指示器风格，默认UIActivityIndicatorViewStyleGray
 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorStyle;

/**
 *  背景透明度，默认1
 */
@property (assign, nonatomic) CGFloat bgAlpha;

/**
 *  title的样式，有三种：Lable、SegmentedControl、Button，默认DSLNavigationBarTitleStyleLable
 */
@property (assign, nonatomic) DSLNavigationBarTitleStyle titleStyle;

/**
 *  同上，取值0-2，能在IB设置，默认0
 */
@property (assign, nonatomic) IBInspectable NSInteger IBTitleStyle;

/**
 *  默认120
 */
@property (assign, nonatomic) IBInspectable CGFloat segmentWidth;

/**
 *  segment title at index 0
 */
@property (strong, nonatomic) IBInspectable NSString *segmentTitle0;

/**
 *  segment title at index 1
 */
@property (strong, nonatomic) IBInspectable NSString *segmentTitle1;

/**
 *  title Lable
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/**
 *  title SegmentedControl
 */
@property (nonatomic, strong, readonly) UISegmentedControl *titleSegment;

/**
 *  title Button
 */
@property (nonatomic, strong, readonly) UIButton *titleButton;

@end
