//
//  HJRefreshHeader.h
//  thrallplus
//
//  Created by admin on 16/11/6.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>
typedef void (^Fefresh)();
@interface HJRefreshHeader : MJRefreshGifHeader
@property (nonatomic,copy)Fefresh refresh;
@end

@interface HJRefreshFooter : MJRefreshBackGifFooter

@end

@interface HJGregariousRefreshHeader : MJRefreshGifHeader

@end

@interface HJGregariousRefreshFooter : MJRefreshBackGifFooter

@end
