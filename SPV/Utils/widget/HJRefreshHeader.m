//
//  HJRefreshHeader.m
//  thrallplus
//
//  Created by admin on 16/11/6.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "HJRefreshHeader.h"
#import <UIImage+GIF.h>

@implementation HJRefreshHeader

- (void)prepare{

    [super prepare];
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新数据" forState:MJRefreshStateRefreshing];
    UIImage *image = [UIImage imageNamed:@"waiting"];
//    UIImage *image = [UIImage sd_animatedGIFNamed:@"waiting"];
    [self setImages:@[image] forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.hidden = YES;
}


-(void)reload{
    if (self.refresh) {
        self.refresh();
    }

}

@end

@implementation HJRefreshFooter

- (void)prepare{
    
    [super prepare];
    
    [self setTitle:@"上拉可以加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即加载更多" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    
}

@end

@implementation HJGregariousRefreshHeader

- (void)prepare{
    
    [super prepare];
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新数据" forState:MJRefreshStateRefreshing];
//    UIImage *image = [UIImage sd_animatedGIFNamed:@"refresh_2"];
    
    UIImage *image = [UIImage imageNamed:@"refresh_2"];
    [self setImages:@[image] forState:MJRefreshStateRefreshing];
    self.stateLabel.textColor = [UIColor whiteColor];
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end

@implementation HJGregariousRefreshFooter

- (void)prepare{
    
    [super prepare];
    [self setTitle:@"上拉可以加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即加载更多" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    self.stateLabel.textColor = [UIColor whiteColor];
}

@end

