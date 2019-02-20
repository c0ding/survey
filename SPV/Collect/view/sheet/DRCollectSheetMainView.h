//
//  DRCollectSheetView.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/18.
//  Copyright © 2019年 训机. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRCollectSheetMainView : UIView

@property (nonatomic ,strong)NSMutableArray <NSString *>*contents;
@property (nonatomic ,strong)NSString *tittle;
@property (nonatomic ,assign)NSInteger currertSlectIndex;
typedef void(^SheetMainBlock)(NSInteger index, NSString* text);
@property (nonatomic ,copy)SheetMainBlock sheetMainBlock;
- (void)show ;
- (void)dismiss ;
@end

NS_ASSUME_NONNULL_END
