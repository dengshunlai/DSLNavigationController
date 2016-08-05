//
//  DSLNavigationBar.m
//  videoForHearthstone
//
//  Created by 邓顺来 on 16/5/15.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "DSLNavigationBar.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation DSLNavigationBar

#pragma mark - Life cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    [self createTitleLabel];
    [self createBackBtn];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, UIColorFromRGB(0xe4e4e4).CGColor);
    CGContextFillRect(context, CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1));
}

#pragma mark - Create UI

- (void)createTitleLabel
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = UIColorFromRGB(0x333333);
    [self addSubview:_titleLabel];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_titleLabel]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_titleLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
}

- (void)createBackBtn
{
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 20, 44, 44);
    [self addSubview:_backBtn];
    [_backBtn setImage:[UIImage imageNamed:@"DSLBack"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Set & Get method

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)setFontSizt:(CGFloat)fontSizt
{
    _fontSizt = fontSizt;
    _titleLabel.font = [UIFont systemFontOfSize:fontSizt];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)setHideBack:(BOOL)hideBack
{
    _hideBack = hideBack;
    _backBtn.hidden = hideBack;
}

- (void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
    [_backBtn setImage:normalImage forState:UIControlStateNormal];
}

- (void)setHighlightImage:(UIImage *)highlightImage
{
    _highlightImage = highlightImage;
    [_backBtn setImage:highlightImage forState:UIControlStateHighlighted];
}

- (void)setBackFrame:(CGRect)backFrame
{
    _backFrame = backFrame;
    _backBtn.frame = backFrame;
}

#pragma mark - Target & Action

- (void)pop:(UIButton *)sender
{
    UIResponder *responder = self.superview.nextResponder;
    if ([responder isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)responder;
        [vc.navigationController popViewControllerAnimated:YES];
    }
}

@end
