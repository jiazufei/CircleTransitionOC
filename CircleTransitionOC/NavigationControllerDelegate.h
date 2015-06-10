//
//  NavigationControllerDelegate.h
//  CircleTransitionOC
//
//  Created by CaoFei on 15/6/9.
//  Copyright (c) 2015年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//要实现这一步，可在右边库中搜索object,并拖拽到左侧Navigation Controller Source的下面
//现在点击object，在右边Identity Inspector中，将其类更改为NavigationControllerDelegate.
//接下来，右击左面板中的UINavigationController，将object赋给UINavigationController的委托，并将其委托属性拖拽到NavigationControllerDelegate 对象上：

@interface NavigationControllerDelegate : NSObject <UINavigationControllerDelegate>
{
    UIPercentDrivenInteractiveTransition * interactionController;
}
//  打开Main.storyboard,右击左侧Navigation Controller Delegate object，将属性和导航控制器连接起来，然后从navigationController属性中 拖到storyboard中的导航控制器上。
@property (nonatomic,weak) IBOutlet UINavigationController * navigationController;

@end
