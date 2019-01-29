//
//  DRSallyTableViewCell.h
//  SPV
//
//  Created by 张逸阳 on 2018/1/5.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRSallyTableViewCell : UITableViewCell
///左边【
@property (nonatomic ,strong) UILabel *leftLabel;
///右边 】
@property (nonatomic ,strong) UILabel *rightLabel;
///中间图片
@property (nonatomic ,strong) UIImageView *midImage;

///说明
@property (nonatomic ,strong) UILabel *explanationLabel;

@property (nonatomic ,strong) UIImageView *leftImage;

- (void)setupValueWithArray:(NSMutableArray *)data andIndexPath:(NSIndexPath *)indexPath;
@end
