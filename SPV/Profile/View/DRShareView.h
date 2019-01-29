//
//  DRShareView.h
//  SPV
//
//  Created by 黄梦炜 on 2018/7/26.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRShareViewDelegate<NSObject>

-(void)clickShareButton:(NSInteger)index;
-(void)cancelClick;
@end

@interface DRShareView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray *shareArray;
@property (nonatomic, weak) id<DRShareViewDelegate>delegate;


@end
