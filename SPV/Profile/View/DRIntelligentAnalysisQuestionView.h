//
//  DRIntelligentAnalysisQuestionView.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/9.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRIntelligentAnalysisQuestionModel.h"

@protocol DRIntelligentAnalysisQuestionViewDelegate <NSObject>
@optional
- (void)didSelectRowAtIndexPathWithModel:(DRIntelligentAnalysisQuestionModel *)model AndIndexPath:(NSIndexPath *)indexPath;
@end

@interface DRIntelligentAnalysisQuestionView : UIView

@property (nonatomic ,strong) NSMutableArray<DRIntelligentAnalysisQuestionModel *> *dataSource;
@property (nonatomic ,assign) id <DRIntelligentAnalysisQuestionViewDelegate>delegate;
@end
