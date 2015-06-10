//
//  CircleTransitionAnimator.m
//  CircleTransitionOC
//
//  Created by CaoFei on 15/6/9.
//  Copyright (c) 2015年 CaoFei. All rights reserved.
//

#import "CircleTransitionAnimator.h"

@implementation CircleTransitionAnimator
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //  1.在超出该方法范围外保持对transitionContext的引用，以便将来访问。
    self.transitionContext = transitionContext;
    
    //
    //  2.创建从容器视图到视图控制器的引用。容器视图是动画发生的地方，切换的视图控制器是动画的一部分。
    UIView * containerView = [transitionContext containerView];
    ViewController * fromViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
   
   ViewController * toViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIButton * button = fromViewController.button;
    //
    //  3.添加toViewController作为containerView的子视图。
    [containerView addSubview:toViewController.view];
    
    //
    //  4.创建两个圆形UIBezierPath实例：一个是按钮的尺寸，一个实例的半径范围可覆盖整个屏幕。最终的动画将位于这两个Bezier路径间。
    UIBezierPath * circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    CGPoint extremePoint = CGPointMake(button.center.x - 0, button.center.y - CGRectGetHeight(toViewController.view.bounds));
//    double radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
    UIBezierPath * circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame,
                                                                                            -sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y)),
                                                                                            -sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y)))];
    
    
    //
    //  5.创建一个新的CAShapeLayer来展示圆形遮罩。你可以在动画之后使用最终的循环路径指定其路径值，以避免图层在动画完成后回弹。
    CAShapeLayer * maskLayer = [CAShapeLayer new];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toViewController.view.layer.mask = maskLayer;
    
    //
    //  6.在关键路径上创建一个CABasicAnimation，从circleMaskPathInitial到circleMaskPathFinal.你也要注册一个委托，因为你要在动画完成后做一些清理工作。
    CABasicAnimation * maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:(UITransitionContextFromViewControllerKey)].view.layer.mask = nil;
}
@end
