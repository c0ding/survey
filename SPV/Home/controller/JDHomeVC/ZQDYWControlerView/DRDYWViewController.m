//
//  DRDYWViewController.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/19.
//  Copyright © 2019 训机. All rights reserved.
//

#import "DRDYWViewController.h"
#import "DRMockData.h"
#import "DRCollectModel.h"
#import "DRCollectTableViewCell.h"
@interface DRDYWViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DRDYWViewController
{
    DRCollectModel *model;
    DRBaseTableView *DYWTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleView:@"福建建行债权包" color:YES];
    [self getData];
}

-(void)getData
{
    model = [DRCollectModel new];
    [model mj_setKeyValues:[[DRMockData shareDRMockData] MyCollectMock]];
    [self createTable];
    

}

-(void)createTable
{
    
    DYWTable = [[DRBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviHeight)];
    DYWTable.delegate = self;
    DYWTable.dataSource = self;
    [self.view addSubview:DYWTable];
    [DYWTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [DYWTable registerClass:[DRCollectTableViewCell class] forCellReuseIdentifier:@"collection"];
    DYWTable.tableFooterView = [UIView new];
    [self tableViewHeadCreate];
    
    UIView *footView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
    DYWTable.tableFooterView = footView;
    
    [self createLowView];
}



-(void)createLowView
{
    
    UIImageView *lowView = [UIImageView new];
    [self.view addSubview:lowView];
    [lowView setUserInteractionEnabled:YES];
    [lowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(82);
    }];
    [lowView setImage:[UIImage imageNamed:@"lookReport"]];
    
    UIButton *btnLook = [UIButton new];
    [lowView addSubview:btnLook];
    [btnLook mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lowView.mas_centerX);
        make.centerY.equalTo(lowView.mas_centerY);
        make.height.offset(50);
        make.width.offset(kWidth(343));
    }];
    [btnLook setBackgroundColor:getUIColor(0xF2A949)];
    [btnLook.layer setCornerRadius:2];
    [btnLook.layer setMasksToBounds:YES];
    [btnLook setTitle:@"查看尽调报告" forState:UIControlStateNormal];
    [btnLook addTarget:self action:@selector(btnLookClick) forControlEvents:UIControlEventTouchUpInside];
    [btnLook setTitleColor:getUIColor(0x26231E ) forState:UIControlStateNormal];
    
    
}

-(void)btnLookClick
{
    
}

-(void)tableViewHeadCreate
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(37))];
    [headView setBackgroundColor:getUIColor(0xF2F2F2)];
    DYWTable.tableHeaderView = headView;
    UILabel *titleLabel = [UILabel new];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.centerY.equalTo(headView.mas_centerY);
        make.height.offset(kHeight(21));
    }];
    [titleLabel setText:[NSString stringWithFormat:@"关注的任务(%ld)",model.collectList.count]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:font(15)]];
    [titleLabel setTextColor:getUIColor(0x26231E)];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight(101);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model.collectList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRCollectListModel *modelIndex = model.collectList[indexPath.row];
    
    DRCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collection" forIndexPath:indexPath];
    cell.model = modelIndex;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

@end
