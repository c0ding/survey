//
//  DRLoginFormView.h
//  SPV
//
//  Created by 张逸阳 on 2019/2/12.
//  Copyright © 2019年 hejiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface DRLoginFormView : UIView

@property (nonatomic ,strong)NSString *placeholder;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,assign)BOOL secureTextEntry;

typedef void(^TextChangeBlock) (NSString *str);
@property (nonatomic,copy) TextChangeBlock textChangeBlock;
@end

NS_ASSUME_NONNULL_END

