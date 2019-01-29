//
//  DRIntelligentAnalysisQuestionModel.h
//  SPV
//
//  Created by 张逸阳 on 2018/5/9.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRIntelligentAnalysisQuestionModel : NSObject
@property (nonatomic ,strong) NSString *question;
@property (nonatomic ,strong) NSString *anwser;
@end


@interface DRDialogueModel : NSObject
@property (nonatomic ,strong) NSString *msg;
@property (nonatomic,assign) BOOL isRight;
@end
