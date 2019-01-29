//
//  DRShareView.m
//  SPV
//
//  Created by 黄梦炜 on 2018/7/26.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRShareView.h"

#import "DRShareButtonCollectionViewCell.h"

@implementation DRShareView
{
    UIView *backView;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI {
    
   
    
    UIButton *cancelBtn = [UIButton new];
    [self addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.bottom.offset(-12);
        make.height.offset(50);
    }];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn.layer setCornerRadius:3];
    [cancelBtn.titleLabel setFont:[UIFont regulerApplicationFontOfSize:font(16)]];
    [cancelBtn addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *contentShareView = [UIView new];
    [self addSubview:contentShareView];
    [contentShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.bottom.equalTo(cancelBtn.mas_top).offset(-9);
        make.height.offset(157);
    }];
    [contentShareView setBackgroundColor:[UIColor whiteColor]];
    [contentShareView.layer setCornerRadius:3];
    
    UILabel *titleLabel = [UILabel new];
    [contentShareView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(13);
        make.centerX.offset(0);
    }];
    [titleLabel setText:@"分享到"];
    [titleLabel setFont:[UIFont regulerApplicationFontOfSize:font(14)]];
    
    UIView *lineVIew = [UIView new];
    [contentShareView addSubview:lineVIew];
    
    [lineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(45);
        make.right.left.offset(0);
        make.height.offset(1);
    }];
    [lineVIew setBackgroundColor:getUIColor(0x4D4D4D)];
    [lineVIew setAlpha:0.5];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 46, SCREEN_WIDTH - 24, 111) collectionViewLayout:layout];
    collection.showsHorizontalScrollIndicator = FALSE;
    [collection setBackgroundColor:[UIColor whiteColor]];
    collection.dataSource = self;
    collection.delegate = self;
    [collection registerClass:[DRShareButtonCollectionViewCell class] forCellWithReuseIdentifier:@"shareButton"];
    [contentShareView addSubview:collection];
}


-(void)btnCancelClick
{
    if ([_delegate respondsToSelector:@selector(cancelClick)]) {
        [_delegate cancelClick];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 24) / 3,111);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DRShareButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shareButton" forIndexPath:indexPath];
    cell.shareDic = self.shareArray[indexPath.item];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(clickShareButton:)]) {
        [_delegate clickShareButton:indexPath.item];
    }
}

-(NSMutableArray *)shareArray
{
    if (!_shareArray) {
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setObject:@"weixin" forKey:@"imageName"];
        [dic1 setObject:@"微信" forKey:@"shareTitle"];
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setObject:@"penyouquan" forKey:@"imageName"];
        [dic2 setObject:@"朋友圈" forKey:@"shareTitle"];
        NSMutableDictionary *dic3= [NSMutableDictionary dictionary];
        [dic3 setObject:@"qq" forKey:@"imageName"];
        [dic3 setObject:@"QQ" forKey:@"shareTitle"];
        
       _shareArray = [NSMutableArray arrayWithObjects:dic1,dic2,dic3, nil];
        
    }
    
    return _shareArray;
}

-(void)showAlphaView
{
    [backView setAlpha:0.7];
}

@end
