//
//  DRTermsExplanationCell.h
//  SPV
//
//  Created by 张逸阳 on 2018/1/5.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRTermsExplanationCell : UITableViewCell
///名词
@property (nonatomic ,strong) UILabel *termsLabel;
///说明
@property (nonatomic ,strong) UILabel *explanationLabel;

@property (nonatomic ,strong) UIImageView *leftImage;

- (void)setupValueWithArray:(NSMutableArray *)data andIndexPath:(NSIndexPath *)indexPath;
@end
