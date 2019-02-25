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
#import "DRReportViewController.h"
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
    [self setTitleView:_obligatoryRightName color:YES];
    [self createTable];
    [self getData];
}

-(void)getData
{
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_obligatoryRightId forKey:@"obligatoryRightId"];
    
    [[request new] getDYWModel:params net:^(DRCollectModel *data, RequestResult *result) {
        model = data;
        [DYWTable reloadData];
    } error:^(RequestResult *result) {
        
    } handleErrorCode:^(NSUInteger errorCode) {
        
    }];
    
    
        
    
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
    DRReportViewController *report = [[DRReportViewController alloc] init];
    report.modelCollect = model;
    report.obligatoryRightId = _obligatoryRightId;
    [self.navigationController pushViewController:report animated:YES];
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
    [titleLabel setText:[NSString stringWithFormat:@"抵押物(%ld)",model.size]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:font(15)]];
    [titleLabel setTextColor:getUIColor(0x26231E)];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight(101);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model.size;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRCollectListModel *modelIndex = model.list[indexPath.row];
    
    DRCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collection" forIndexPath:indexPath];
    cell.collectVC = NO;
    cell.model = modelIndex;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DRCollectListModel *modelIndex = model.list[indexPath.row];
    
    return modelIndex.attention == 1 ? @"关注":@"取消关注";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    DRCollectListModel *modelIndex = model.list[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:modelIndex.guaranteeId forKey:@"guaranteeId"];
        
        [[request new] attentionClick:params net:^(id data, RequestResult *result) {
            
            [self getData];
            
        } error:^(RequestResult *result) {
            
        } handleErrorCode:^(NSUInteger errorCode) {
            
        }];
        
    }
}

@end
