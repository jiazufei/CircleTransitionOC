//
//  NavigationControllerDelegate.m
//  CircleTransitionOC
//
//  Created by CaoFei on 15/6/9.
//  Copyright (c) 2015年 CaoFei. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "CircleTransitionAnimator.h"
@implementation NavigationControllerDelegate


//  这一步会创建UIPanGestureRecognizer，并将该对象添加到导航控制器的视图上，并得到panned:方法中的手势回调函数
- (void)awakeFromNib{
    [super awakeFromNib];
    UIPanGestureRecognizer * panGesture =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panned:)];
    [self.navigationController.view addGestureRecognizer:panGesture];
}

-(void)panned:(UIPanGestureRecognizer*)gestureRecognizer{
    

    switch (gestureRecognizer.state) {
            //  .Began: 只要识别了手势，那么它会初始化一个UIPercentDrivenInteractiveTransition对象并将其赋给interactionController属性。
            //  如果你切换到第一个视图控制器，它初始化了一个push，如果是在第二个视图控制器，那么初始化的是pop。Pop非常简单，但是对于push，你需要从此前创建的按钮底部手动完成segue.
            //  反过来，push/pop调用触发了NavigationControllerDelegate方法调用返回self.interactionController.这样属性就有了non-nil值。
        case UIGestureRecognizerStateBegan:
        {
            interactionController =[UIPercentDrivenInteractiveTransition new];
            if (self.navigationController.viewControllers.count>1) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [[self.navigationController topViewController]performSegueWithIdentifier:@"PushSegue" sender:nil];
            }
        }
            break;
            //      Changed: 这种状态下，你完成了手势的进程并更新了interactionController.插入动画是项艰苦的工作，不过苹果已经做了这部分的工作，你无需做什么事情。
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [gestureRecognizer translationInView:self.navigationController.view];
            CGFloat completionProgress = translation.x/CGRectGetWidth(self.navigationController.view.bounds);
            [interactionController updateInteractiveTransition:completionProgress];
        }
            break;
             //      Ended: 你已经看到了pan手势的速度。如果是正数，转场就完成了；如果不是，就是被取消了。你也可以将interactionController设置为nil，这样她就承担了清理的任务。
        case UIGestureRecognizerStateEnded:
        {
            if ([gestureRecognizer velocityInView:self.navigationController.view].x>0) {
                [interactionController finishInteractiveTransition];
            }else{
                [interactionController cancelInteractiveTransition];
            }
            interactionController = nil;
        }
            break;
            //      如果是其他任何状态，你可以简单取消转场并将interactionController设置为nil.
        default:{
            [interactionController cancelInteractiveTransition];
            interactionController = nil;
        }
            break;
    }
}


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    return  [CircleTransitionAnimator new];
}
-(id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return interactionController;
}



@end
