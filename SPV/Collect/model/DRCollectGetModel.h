//
//  DRCollectGetModel.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/15.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class DRCollectGetData, PicModel,DataModel,AttachmentModel,SelectModel;
@interface DRCollectGetModel : DRBaseModel
@property (nonatomic ,strong)DRCollectGetData *data;
@end

@interface DRCollectGetData :NSObject
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSMutableArray <DataModel*>*dataList ;
@property(nonatomic,assign) double longitude;
@property(nonatomic,assign) double      latitude;
@property(nonatomic,strong) NSString *locationAddr;
@property(nonatomic,strong) NSString *locationSurrounding;
@property(nonatomic,strong) NSMutableArray <PicModel*>*     picList;
@property(nonatomic,strong) NSString *picRemark;
@property(nonatomic,assign) long long systemTime;
@end


@interface DataModel : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *param;
@property(nonatomic,assign) NSInteger type;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,assign) BOOL needTransform;
@property(nonatomic,strong) NSMutableArray<SelectModel *> *select;
@property(nonatomic,strong) NSMutableArray<AttachmentModel*> *attachmentList;
@end



@interface AttachmentModel : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *url;
@end

@interface SelectModel : NSObject
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *value;
@end


@interface PicModel : NSObject

@end
NS_ASSUME_NONNULL_END
