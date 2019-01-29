//
//  DRDialogueCell.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/10.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRIntelligentAnalysisQuestionModel.h"
@interface DRDialogueCell : UITableViewCell
@property (nonatomic,strong) UIImageView *backView; // 气泡
@property (nonatomic,strong) UILabel *contentLabel; // 气泡内文本

@property (nonatomic,strong) DRDialogueModel *model;
@end
