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

@property (nonatomic, strong) IBInspectable NSString *title;
@property (nonatomic, assign) IBInspectable CGFloat fontSizt;
@property (nonatomic, strong) IBInspectable UIColor *titleColor;
@property (nonatomic, strong) IBInspectable UIImage *normalImageForBackBtn;
@property (nonatomic, strong) IBInspectable UIImage *highlightImageForBackBtn;
@property (nonatomic, assign) IBInspectable BOOL isHideBackBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backBtn;

@end
