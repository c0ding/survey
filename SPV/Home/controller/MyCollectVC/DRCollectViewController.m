//
//  DRCollectViewController.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/18.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import "DRCollectViewController.h"
#import "DRMockData.h"
#import "DRCollectModel.h"
#import "DRCollectTableViewCell.h"
@interface DRCollectViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DRCollectViewController
{
    DRCollectModel *model;
    DRBaseTableView *collectTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    collectTable = [[DRBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviHeight)];
    collectTable.delegate = self;
    collectTable.dataSource = self;
    [self.view addSubview:collectTable];
    [collectTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [collectTable registerClass:[DRCollectTableViewCell class] forCellReuseIdentifier:@"collection"];
    collectTable.tableFooterView = [UIView new];
    [self tableViewHeadCreate];
    
}

-(void)tableViewHeadCreate
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(37))];
    [headView setBackgroundColor:getUIColor(0xF2F2F2)];
    collectTable.tableHeaderView = headView;
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
