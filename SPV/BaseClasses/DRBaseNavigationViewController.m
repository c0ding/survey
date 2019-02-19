//
//  DRBaseNavigationViewController.m
//  SPV
//
//  Created by 黄梦炜 on 2017/12/6.
//  Copyright © 2017年 hejiahuan. All rights reserved.
//

#import "DRBaseNavigationViewController.h"

@interface DRBaseNavigationViewController ()

@end

@implementation DRBaseNavigationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    // 禁用右滑切换
//    self.interactivePopGestureRecognizer.enabled = YES;
//    // 设置Bar背景色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
////    // 设置Bar不透明
//    [self.navigationBar setTranslucent:NO];
//    self.navigationBarHidden = YES;
    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18]; // 字体大小
//    attrs[NSForegroundColorAttributeName] = [UIColor blackColor]; // 颜色
    UINavigationBar *naviBar = [UINavigationBar appearance];
//    [naviBar setTitleTextAttributes:attrs];
    // 解决iOS11界面缩放后导航栏空出状态栏的空隙的问题 方法1
    [naviBar setBackgroundImage:[UIImage imageNamed:@"navi"] forBarMetrics:UIBarMetricsDefault];
    
    
}

-(void) backBtn
{
   
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
