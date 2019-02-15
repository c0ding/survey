//
//  DRHomePageViewController.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/12.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import "DRHomePageViewController.h"

@interface DRHomePageViewController ()

@end

@implementation DRHomePageViewController
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2-60, 0, 120, 30)];
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(0, 0, 40, 30);
    [firstBtn setTitle:@"邂逅" forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [titleView addSubview:firstBtn];
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(80, 0, 40, 30);
    [secondBtn setTitle:@"附近" forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [secondBtn addTarget:self action:@selector(showNearby:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:secondBtn];
    self.navigationItem.titleView = titleView;
   
    // Do any additional setup after loading the view.
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
