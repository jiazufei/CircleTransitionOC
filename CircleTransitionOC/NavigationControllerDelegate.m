//
//  NavigationControllerDelegate.m
//  CircleTransitionOC
//
//  Created by CaoFei on 15/6/9.
//  Copyright (c) 2015年 CaoFei. All rights reserved.
//

#import "NavigationControllerDelegate.h"

@implementation NavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    return nil;
}
@end
