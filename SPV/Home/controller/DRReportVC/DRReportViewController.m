//
//  DRReportViewController.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/21.
//  Copyright © 2019 训机. All rights reserved.
//

#import "DRReportViewController.h"
#import "DRReportLeftTableViewCell.h"
#import "DRReportRightTableViewCell.h"
#import "DRReportModel.h"
@interface DRReportViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DRReportViewController
{
    DRBaseTableView *leftTable;
    DRBaseTableView *rightTable;
    DRReportModel *model;
    NSInteger selectCell;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    selectCell = 0;
    [self setTitleView:@"尽调报告" color:YES];
    
    
    
    [self createTableleftAndRight];
    // Do any additional setup after loading the view.
}

-(void)getData
{
    @weakify(self)
    DRCollectListModel *modelCollectList = _modelCollect.list[0];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params  setObject:_obligatoryRightId forKey:@"obligatoryRightId"];
    [params setObject:modelCollectList.guaranteeId forKey:@"guaranteeId"];
    [[request new] getReportModel:params net:^(id data, RequestResult *result) {
        model = data;
        [self createTableleftAndRight];
    } error:^(RequestResult *result) {
        
    } handleErrorCode:^(NSUInteger errorCode) {
        
    }];
    
}


-(void)createTableleftAndRight
{
    leftTable = [DRBaseTableView new] ;
    [self.view addSubview:leftTable];
    
    [leftTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(kWidth(92.5));
    }];
    
    leftTable.dataSource = self;
    leftTable.delegate = self;
    [leftTable registerClass:[DRReportLeftTableViewCell class] forCellReuseIdentifier:@"left"];
    [leftTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    leftTable.estimatedRowHeight=1000.0;
    leftTable.rowHeight=UITableViewAutomaticDimension;
    
    
    UIView *lineView = [UIView new];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftTable.mas_right).offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(0.5);
    }];
    [lineView setBackgroundColor:getUIColor(0xA9A9A9)];
    
    
    rightTable = [DRBaseTableView new] ;
    [self.view addSubview:rightTable];
    [rightTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.offset(0);
    }];
    rightTable.estimatedRowHeight=1000.0;
    
    rightTable.rowHeight=UITableViewAutomaticDimension;
    
    [rightTable registerClass:[DRReportRightTableViewCell class] forCellReuseIdentifier:@"right"];
    rightTable.dataSource = self;
    rightTable.delegate = self;
    [rightTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == leftTable) {
        
        [leftTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kWidth(92.5));
        }];
    } else {
        
        [leftTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kWidth(62));
        }];
        
    }
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView == leftTable? 5 :100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *reCell;
    if (tableView == leftTable) {
        DRReportLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"left" forIndexPath:indexPath];
        cell.tag = indexPath.row + 1;
        cell.selectTag = selectCell;
        cell.model =_modelCollect.list[indexPath.row];
        reCell = cell;
    } else {
        DRReportRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"right" forIndexPath:indexPath];
        
        reCell = cell;
    }
    return reCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == leftTable) {
        selectCell = indexPath.row;
        [leftTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kWidth(92.5));
        }];
        [leftTable reloadData];
    } else {
        [leftTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kWidth(62));
        }];
    }
    
}

@end
