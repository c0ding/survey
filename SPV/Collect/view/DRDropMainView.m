//
//  DRDropMainView.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/13.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRDropMainView.h"
#import "DRCollectDropView.h"


@interface DRDropMainView( )
@property (nonatomic ,strong) NSMutableArray <DRCollectDropView *> *dropViews;
@property (nonatomic ,strong) NSArray <NSString *> *dropTexts;

@end

@implementation DRDropMainView

- (NSArray<NSString *> *)dropTexts {
    if (!_dropTexts) {
        _dropTexts = @[@"待尽调",@"无需尽调",@"已尽调"];
    }
    return _dropTexts;
}
- (instancetype)init {
    
    
    
    self = [super init];
    self.backgroundColor = [UIColor blackColor];
    if (self) {
        _dropViews = [NSMutableArray array];
        
        WEAKSELF
        for (int i = 0; i<self.dropTexts.count; i++) {
            DRCollectDropView *collectDropView = [[DRCollectDropView alloc]init];
            collectDropView.text = self.dropTexts[i];
            
            collectDropView.tag = 100+i;
            [self addSubview:collectDropView];
            collectDropView.frame = CGRectMake(0, i*kRowH, kScreenWidth, kRowH);
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            
            [[tap rac_gestureSignal] subscribeNext:^(id x) {
                [weakSelf dropMainClick:collectDropView];
                
            }];
            [collectDropView addGestureRecognizer:tap];
            
            [_dropViews addObject:collectDropView];
        }
    }
    return self;
}


- (void)setCurrertSelect:(NSInteger)currertSelect {
    for (int i = 0; i<_dropViews.count; i++) {
        if (currertSelect == i) {
            DRCollectDropView *collect = _dropViews[i];
            [collect showSelect:YES];
        }
    }
    _currertSelect = currertSelect;
}


- (void)dropMainClick:(DRCollectDropView *)collectDropView{
    
    for (int i = 0; i<_dropViews.count; i++) {
        if (collectDropView.tag == 100+i) {
            [collectDropView showSelect:YES];
            
            _currertSelect = i;
            continue;
        }
        DRCollectDropView *collect = (DRCollectDropView *)[self viewWithTag:100+i];
        [collect showSelect:NO];
    }
    
    if (self.dropMainBlock) {
        self.dropMainBlock(_currertSelect,_dropTexts[_currertSelect]);
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
