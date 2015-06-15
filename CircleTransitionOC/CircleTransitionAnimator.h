//
//  CircleTransitionAnimator.h
//  CircleTransitionOC
//
//  Created by CaoFei on 15/6/9.
//  Copyright (c) 2015年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIViewControllerTransitioning.h>
#import "ViewController.h"
@interface CircleTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property(nonatomic,weak)id <UIViewControllerContextTransitioning> transitionContext;

@end
