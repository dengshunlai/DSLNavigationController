//
//  DSLNavigationController.m
//  DSLNavigationControllerDemo
//
//  Created by dengshunlai on 16/6/2.
//  Copyright © 2016年 dengshunlai. All rights reserved.
//

#import "DSLNavigationController.h"

static CGFloat const kWidthScale = 0.9;
static CGFloat const kHeightScale = 0.9;

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface DSLNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) DSLInteractiveAnimator *animator;

@end

@implementation DSLNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController type:(NSInteger)type
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self initialization];
        self.type = type;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
        self.type = 0;
    }
    return self;
}

- (void)initialization
{
    ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setType:(NSInteger)type
{
    _type = type;
    if (_type == 99) {
        if (_animator) {
            _animator = nil;
            self.navigationBarHidden = NO;
            self.delegate = nil;
            self.interactivePopGestureRecognizer.enabled = YES;
        }
        [self.view sendSubviewToBack:self.navigationBar];
    } else {
        if (!_animator) {
            _animator = [[DSLInteractiveAnimator alloc] initWithNavc:self];
            self.navigationBarHidden = YES;
            self.delegate = _animator;
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

@end


@interface DSLInteractiveAnimator ()

@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, assign) BOOL isInteractive;
@property (nonatomic, weak) DSLNavigationController *navc;

@end

@implementation DSLInteractiveAnimator

- (instancetype)initWithNavc:(DSLNavigationController *)navc
{
    self = [super init];
    if (self) {
        _navc = navc;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    if (_navc.type == 0) {
        if (_isPush) {
            toView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
            [containerView addSubview:toView];
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                fromView.transform = CGAffineTransformScale(fromView.transform, kWidthScale, kHeightScale);
                toView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            } completion:^(BOOL finished) {
                fromView.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        } else {
            toView.transform = CGAffineTransformScale(toView.transform, kWidthScale, kHeightScale);
            [containerView insertSubview:toView belowSubview:fromView];
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                toView.transform = CGAffineTransformIdentity;
                fromView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
            } completion:^(BOOL finished) {
                toView.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
    } else if (_navc.type == 1) {
        //模仿系统push
        if (_isPush) {
            toView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
            toView.layer.shadowOpacity = 0.5;
            toView.layer.shadowOffset = CGSizeMake(-5, 5);
            toView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            toView.layer.shadowPath = [UIBezierPath bezierPathWithRect:toView.bounds].CGPath;
            [containerView addSubview:toView];
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                fromView.frame = CGRectMake(- kScreenWidth / 4, 0, kScreenWidth, kScreenHeight);
                toView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        } else {
            [containerView insertSubview:toView belowSubview:fromView];
            fromView.layer.shadowOpacity = 0.5;
            fromView.layer.shadowOffset = CGSizeMake(-5, 5);
            fromView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            fromView.layer.shadowPath = [UIBezierPath bezierPathWithRect:toView.bounds].CGPath;
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                toView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                fromView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
    } else if (_navc.type == 2) {
        //碎片fragment
        if (_isPush) {
            UIView *toViewSnapshot = [toView snapshotViewAfterScreenUpdates:YES];
            [containerView insertSubview:toView belowSubview:fromView];
            CGFloat fragmentSize = 20;
            NSInteger column = fromView.frame.size.width / fragmentSize + 1;
            NSInteger row = fromView.frame.size.height / fragmentSize + 1;
            NSMutableArray *fragments = [NSMutableArray array];
            for (int i = 0; i < row; i++) {
                for (int j = 0; j < column; j++) {
                    UIView *fragmentView = [toViewSnapshot resizableSnapshotViewFromRect:CGRectMake(j * fragmentSize, i * fragmentSize, fragmentSize, fragmentSize) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
                    fragmentView.frame = CGRectMake(j * fragmentSize, i * fragmentSize, fragmentSize, fragmentSize);
                    [fragments addObject:fragmentView];
                    [containerView addSubview:fragmentView];
                    fragmentView.transform = CGAffineTransformTranslate(fragmentView.transform, arc4random() % 30 * 50, 0);
                    fragmentView.alpha = 0;
                }
            }
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                for (UIView *fragmentView in fragments) {
                    fragmentView.transform = CGAffineTransformIdentity;
                    fragmentView.alpha = 1;
                }
            } completion:^(BOOL finished) {
                for (UIView *fragmentView in fragments) {
                    [fragmentView removeFromSuperview];
                }
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        } else {
            UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:YES];
            [containerView addSubview:toView];
            toView.frame = fromView.bounds;
            CGFloat fragmentSize = 20;
            NSInteger column = fromView.frame.size.width / fragmentSize + 1;
            NSInteger row = fromView.frame.size.height / fragmentSize + 1;
            NSMutableArray *fragments = [NSMutableArray array];
            for (int i = 0; i < row; i++) {
                for (int j = 0; j < column; j++) {
                    UIView *fragmentView = [fromViewSnapshot resizableSnapshotViewFromRect:CGRectMake(j * fragmentSize, i * fragmentSize, fragmentSize, fragmentSize) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
                    fragmentView.frame = CGRectMake(j * fragmentSize, i * fragmentSize, fragmentSize, fragmentSize);
                    [fragments addObject:fragmentView];
                    [containerView addSubview:fragmentView];
                    fragmentView.alpha = 1;
                }
            }
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                for (UIView *fragmentView in fragments) {
                    fragmentView.transform = CGAffineTransformTranslate(fragmentView.transform, arc4random() % 30 * 50, 0);
                    fragmentView.alpha = 0;
                }
            } completion:^(BOOL finished) {
                for (UIView *fragmentView in fragments) {
                    [fragmentView removeFromSuperview];
                }
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
    }
    //参照type=0，1，定义你自己的转场方式。
}

#pragma mark - UINavigationControllerDelegate
//push/pop会顺序调用下面两个方法
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC

{
    switch (operation) {
        case UINavigationControllerOperationPush: {
            UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panPop:)];
            pan.edges = UIRectEdgeLeft;
            [toVC.view addGestureRecognizer:pan];
            _isPush = YES;
        }
            break;
        case UINavigationControllerOperationPop: {
            _isPush = NO;
        }
            break;
        default:
            break;
    }
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return _isInteractive ? self : nil;
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Target&Selector

- (void)panPop:(UIScreenEdgePanGestureRecognizer *)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isInteractive = YES;
            [_navc popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [sender translationInView:_navc.view];
            CGFloat pecent = point.x / kScreenWidth;
            [self updateInteractiveTransition:pecent];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint point = [sender translationInView:_navc.view];
            CGFloat pecent = point.x / kScreenWidth;
            if (pecent > 0.35) {
                self.completionSpeed = 1;
                [self finishInteractiveTransition];
            } else {
                self.completionSpeed = 0.5;
                [self cancelInteractiveTransition];
            }
            _isInteractive = NO;
        }
            break;
        default:
            break;
    }
}

@end
