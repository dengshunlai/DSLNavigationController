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

@property (assign, nonatomic) IBInspectable CGRect backFrame;

@property (nonatomic, strong) IBInspectable UIImage *normalImage;
@property (nonatomic, strong) IBInspectable UIImage *highlightImage;
@property (nonatomic, assign) IBInspectable BOOL hideBack;

@property (nonatomic, strong, readonly) IBInspectable UILabel *titleLabel;

@property (nonatomic, strong, readonly) IBInspectable UIButton *backBtn;

@end
