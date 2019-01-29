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
//    // 设置Bar不透明
    [self.navigationBar setTranslucent:NO];
    self.navigationBarHidden = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
