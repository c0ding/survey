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


-(void)viewWillAppear:(BOOL)animated
{
    [[request new] getCollectModel:^(DRCollectModel *data, RequestResult *result) {
        model = data;
        [collectTable reloadData];
    } error:^(RequestResult *result) {
        
    } handleErrorCode:^(NSUInteger errorCode) {
        
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
}

-(void)getData
{
   
    
    @weakify(self)
    
    
    [[request new] getCollectModel:^(DRCollectModel *data, RequestResult *result) {
        model = data;
        [self createTable];
    } error:^(RequestResult *result) {
        
    } handleErrorCode:^(NSUInteger errorCode) {
        
        
    }];
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
    [titleLabel setText:[NSString stringWithFormat:@"关注的任务(%ld)",model.size]];
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
    cell.collectVC = YES;
    cell.model = modelIndex;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return @"取消关注";
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
