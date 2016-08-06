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
@property (strong, nonatomic) NSLayoutConstraint *titleSegmentCenterXConstraint;
@property (strong, nonatomic) NSLayoutConstraint *titleButtonCenterXConstraint;

@property (strong, nonatomic) NSArray *activetyANDtitleLabelConstraints;
@property (strong, nonatomic) NSArray *activetyANDtitleSegmentConstraints;
@property (strong, nonatomic) NSArray *activetyANDtitleButtonConstraints;

@end

@implementation DSLNavigationBar

@synthesize titleLabel = _titleLabel, titleSegment = _titleSegment;

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
    self.titleStyle = DSLNavigationBarTitleStyleSegment;
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
        switch (_titleStyle) {
            case DSLNavigationBarTitleStyleLable: {
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
                if (!self.activetyANDtitleLabelConstraints.count) {
                    self.activetyANDtitleLabelConstraints =
                    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_activityIndicator]-5-[_titleLabel]"
                                                            options:0
                                                            metrics:nil
                                                              views:@{@"_activityIndicator":self.activityIndicator,
                                                                      @"_titleLabel":self.titleLabel}];
                    [self addConstraints:self.activetyANDtitleLabelConstraints];
                }
            }
                break;
            case DSLNavigationBarTitleStyleSegment: {
                [self removeConstraint:self.titleSegmentCenterXConstraint];
                self.titleSegmentCenterXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                attribute:NSLayoutAttributeCenterX
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:_titleSegment
                                                                                attribute:NSLayoutAttributeCenterX
                                                                               multiplier:1
                                                                                 constant:-10];
                [self addConstraint:self.titleSegmentCenterXConstraint];
                [UIView animateWithDuration:0.2 animations:^{
                    [self layoutIfNeeded];
                }];
                if (!self.activetyANDtitleSegmentConstraints.count) {
                    self.activetyANDtitleSegmentConstraints =
                    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_activityIndicator]-5-[_titleSegment]"
                                                            options:0
                                                            metrics:nil
                                                              views:@{@"_activityIndicator":self.activityIndicator,
                                                                      @"_titleSegment":self.titleSegment}];
                    [self addConstraints:self.activetyANDtitleSegmentConstraints];
                }
            }
                break;
            case DSLNavigationBarTitleStyleButton: {
                ;
            }
                break;
            default:
                break;
        }
        [self.activityIndicator startAnimating];
        self.activityIndicator.hidden = NO;
    } else {
        switch (_titleStyle) {
            case DSLNavigationBarTitleStyleLable: {
                [self removeConstraint:self.titleLabelCenterXConstraint];
                self.titleLabelCenterXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                attribute:NSLayoutAttributeCenterX
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:_titleLabel
                                                                                attribute:NSLayoutAttributeCenterX
                                                                               multiplier:1
                                                                                 constant:0];
                [self addConstraint:self.titleLabelCenterXConstraint];
            }
                break;
            case DSLNavigationBarTitleStyleSegment: {
                [self removeConstraint:self.titleSegmentCenterXConstraint];
                self.titleSegmentCenterXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:_titleSegment
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                 multiplier:1
                                                                                   constant:0];
                [self addConstraint:self.titleSegmentCenterXConstraint];
            }
                break;
            case DSLNavigationBarTitleStyleButton: {
                ;
            }
                break;
            default:
                break;
        }
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    }
}

- (void)setTitleStyle:(DSLNavigationBarTitleStyle)titleStyle
{
    _titleStyle = titleStyle;
    switch (titleStyle) {
        case DSLNavigationBarTitleStyleLable: {
            self.titleLabel.hidden = NO;
            _titleSegment.hidden = YES;
            _titleButton.hidden = YES;
        }
            break;
        case DSLNavigationBarTitleStyleSegment: {
            self.titleSegment.hidden = NO;
            _titleLabel.hidden = YES;
            _titleButton.hidden = YES;
        }
            break;
        default:
            break;
    }
}

#pragma mark - Lazy Load

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
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
    return _titleLabel;
}

- (UISegmentedControl *)titleSegment
{
    if (!_titleSegment) {
        _titleSegment = [[UISegmentedControl alloc] initWithItems:@[@"one",@"two"]];
        _titleSegment.selectedSegmentIndex = 0;
        [self addSubview:_titleSegment];
        _titleSegment.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_titleSegment
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleSegment
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:0
                                                        multiplier:1
                                                          constant:120]];
        self.titleSegmentCenterXConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                          attribute:NSLayoutAttributeCenterX
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:_titleSegment
                                                                          attribute:NSLayoutAttributeCenterX
                                                                         multiplier:1
                                                                           constant:0];
        [self addConstraint:self.titleSegmentCenterXConstraint];
    }
    return _titleSegment;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_activityIndicatorStyle];
        [self addSubview:_activityIndicator];
        _activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
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
