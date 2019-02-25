//
//  DRZQListViewController.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/18.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import "DRZQListViewController.h"
#import "DRMockData.h"
#import "DRZQListModel.h"
#import "DRZQTableViewCell.h"
#import "DRDYWViewController.h"
@interface DRZQListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DRZQListViewController
{
    DRZQListModel *model;
    DRBaseTableView *ZQListTable;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:_assetPackageName color:YES];
    [self getData];
   
    // Do any additional setup after loading the view.
}


-(void)getData {
   
   
    [self createTableView];
    
    
    @weakify(self)
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_assetPackageId forKey:@"assetPackageId"];
    [[request new] getZQModel:params net:^(id data, RequestResult *result) {
        model = data;
        [ZQListTable reloadData];
        
    } error:^(RequestResult *result) {
        
    } handleErrorCode:^(NSUInteger errorCode) {
        
    }];
}


-(void)createTableView {
    ZQListTable = [[DRBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviHeight) style:UITableViewStyleGrouped];
    ZQListTable.delegate = self;
    ZQListTable.dataSource = self;
    [ZQListTable registerClass:[DRZQTableViewCell class] forCellReuseIdentifier:@"ZQ"];
    [ZQListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:ZQListTable];
    [self tableViewHeadCreate];
    
}

-(void)tableViewHeadCreate
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(37))];
    [headView setBackgroundColor:getUIColor(0xF2F2F2)];
    ZQListTable.tableHeaderView = headView;
    UILabel *titleLabel = [UILabel new];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(16));
        make.centerY.equalTo(headView.mas_centerY);
        make.height.offset(kHeight(21));
    }];
    [titleLabel setText:[NSString stringWithFormat:@"债权(%ld)",model.size]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:font(15)]];
    [titleLabel setTextColor:getUIColor(0x26231E)];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model.list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight(92);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRZQListDetailModel *modelList = model.list[indexPath.row];
    DRZQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZQ" forIndexPath:indexPath];
    cell.tag = indexPath.row + 1;
    cell.model= modelList;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     DRZQListDetailModel *modelList = model.list[indexPath.row];
    DRDYWViewController *DYWVC = [[DRDYWViewController alloc] init];
    DYWVC.obligatoryRightId = modelList.obligatoryRightId;
    DYWVC.obligatoryRightName = modelList.obligatoryRightName;
    [self.navigationController pushViewController:DYWVC animated:YES];
}

@end
