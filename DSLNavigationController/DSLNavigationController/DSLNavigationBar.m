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

#define UIColorFromRGBA(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface DSLNavigationBar ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelCenterXConstraint;

@end

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
    _activityIndicatorStyle = UIActivityIndicatorViewStyleGray;
    _bgAlpha = 1;
    [self createTitleLabel];
    [self createBackBtn];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, UIColorFromRGBA(0xe4e4e4, _bgAlpha).CGColor);
    CGContextFillRect(context, CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1));
}

#pragma mark - Create UI

- (void)createTitleLabel
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textColor = UIColorFromRGB(0x333333);
    [self addSubview:_titleLabel];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_titleLabel]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_titleLabel)]];
    self.titleLabelCenterXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                    attribute:NSLayoutAttributeCenterX
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:_titleLabel
                                                                    attribute:NSLayoutAttributeCenterX
                                                                   multiplier:1
                                                                     constant:0];
    [self addConstraint:self.titleLabelCenterXConstraint];
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

- (void)setBgAlpha:(CGFloat)bgAlpha
{
    _bgAlpha = bgAlpha;
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:bgAlpha];
    [self setNeedsDisplay];
}

- (void)setActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityIndicatorStyle
{
    _activityIndicatorStyle = activityIndicatorStyle;
    _activityIndicator.activityIndicatorViewStyle = activityIndicatorStyle;
}

- (void)setShowActivityIndicator:(BOOL)showActivityIndicator
{
    if (showActivityIndicator) {
        [self removeConstraint:self.titleLabelCenterXConstraint];
        self.titleLabelCenterXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_titleLabel
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1
                                                                         constant:-10];
        [self addConstraint:self.titleLabelCenterXConstraint];
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
        [self.activityIndicator startAnimating];
        self.activityIndicator.hidden = NO;
    } else {
        [self removeConstraint:self.titleLabelCenterXConstraint];
        self.titleLabelCenterXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_titleLabel
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1
                                                                         constant:0];
        [self addConstraint:self.titleLabelCenterXConstraint];
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    }
}

#pragma mark - Lazy Load

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_activityIndicatorStyle];
        [self addSubview:_activityIndicator];
        _activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_activityIndicator]-5-[_titleLabel]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_activityIndicator,_titleLabel)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_activityIndicator
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:-10]];
    }
    return _activityIndicator;
}

#pragma mark - Target & Action

- (void)pop:(UIButton *)sender
{
    if (self.backBtnClickBlock) {
        self.backBtnClickBlock();
    } else {
        UIResponder *responder = self.superview.nextResponder;
        if ([responder isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)responder;
            [vc.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
