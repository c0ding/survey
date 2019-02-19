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


@interface DRZQListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DRZQListViewController
{
    DRZQListModel *model;
    DRBaseTableView *ZQListTable;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
     [self setTitleView:@"福建建行债权包" color:YES];
    [self getData];
   
    // Do any additional setup after loading the view.
}


-(void)getData {
    model = [DRZQListModel new];
    [model mj_setKeyValues:[[DRMockData shareDRMockData] ZQListMock]];
    [self createTableView];
}


-(void)createTableView {
    ZQListTable = [[DRBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviHeight) style:UITableViewStyleGrouped];
    ZQListTable.delegate = self;
    ZQListTable.dataSource = self;
    [ZQListTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZQ"];
    [self.view addSubview:ZQListTable];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model.ZQList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight(92);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZQ" forIndexPath:indexPath];
    return cell;
}


@end
