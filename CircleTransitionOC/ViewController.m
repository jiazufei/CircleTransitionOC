//
//  ViewController.m
//  CircleTransitionOC
//
//  Created by CaoFei on 15/6/9.
//  Copyright (c) 2015年 CaoFei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)circleTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
