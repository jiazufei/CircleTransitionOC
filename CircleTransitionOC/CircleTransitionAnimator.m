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
    //1
    self.transitionContext = transitionContext;
    
    //2
    UIView * containerView = [transitionContext containerView];
    ViewController * fromViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
   ViewController * toViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIButton * button = fromViewController.button;

    
    //3
    [toViewController.view addSubview:containerView];
    
    //4
    UIBezierPath * circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    CGPoint extremePoint = CGPointMake(button.center.x-0, button.center.y - CGRectGetHeight(toViewController.view.bounds));
    double radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
    UIBezierPath * circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    //5
    CAShapeLayer * maskLayer = [CAShapeLayer new];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toViewController.view.layer.mask = maskLayer;
    
    //6
    CABasicAnimation * maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:(UITransitionContextFromViewControllerKey).];
    self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
}
@end
