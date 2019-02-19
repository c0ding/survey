//
//  DRJDHomeViewController.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/13.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import "DRJDHomeViewController.h"
#import "DRMockData.h"
#import "DRJDHomeModel.h"
#import "DRSearchViewController.h"
#import "PYSearch.h"
#import "DRZQListViewController.h"
@interface DRJDHomeViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,PYSearchViewControllerDelegate>

@end

@implementation DRJDHomeViewController
{
    DRJDHomeModel *model;
    
    DRBaseTableView *DRJDTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    // Do any additional setup after loading the view.
}


-(void) getData {

    
    model = [DRJDHomeModel new];
    [model mj_setKeyValues:[[DRMockData shareDRMockData] JDHomeMock]];
    
    [self setTableView];
    
}


-(void)setTableView {
    DRJDTable = [[DRBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviHeight) style:UITableViewStyleGrouped];
    DRJDTable.delegate = self;
    DRJDTable.dataSource = self;
    [DRJDTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"JD"];
    [self.view addSubview:DRJDTable];
    [self headView];

}

-(void)headView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 16, SCREEN_WIDTH - 16, 36)];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField.layer setBorderWidth:0.5];
    [textField.layer setBorderColor:getUIColor(0xE5E5E5).CGColor];
    [headView addSubview:textField];
    [textField.layer setCornerRadius:2];
    UIImageView *imageImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [imageImg setImage:[UIImage imageNamed:@"search"]];
    [imageImg setContentMode:UIViewContentModeCenter];
    [textField setLeftView:imageImg];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setPlaceholder:@"支持搜索债权户、抵押物"];
    [textField setFont:[UIFont regulerApplicationFontOfSize:font(15)]];
    textField.delegate = self;
    DRJDTable.tableHeaderView = headView;
    
}

// textfield 协议

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程语言" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        //        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. 设置风格
   
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:searchViewController  animated:YES completion:nil];

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return model.assignmentList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DRAssignmentListModel *listModel = model.assignmentList[section];
    return listModel.timeList.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Count(29);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Count(29))];
    UILabel *headTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH- 32, Count(29))];
    DRAssignmentListModel *listModel = model.assignmentList[section];
    [headTitle setText:listModel.time];
    [headTitle setTextColor:getUIColor(0x26231E)];
    [headTitle setFont:[UIFont boldSystemFontOfSize:font(15)]];
    [headView addSubview:headTitle];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRAssignmentListModel *listModel = model.assignmentList[indexPath.section];
    DRTimeListModel *timeModel = listModel.timeList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JD" forIndexPath:indexPath];
    [cell.textLabel setText:timeModel.assignmentName];
    [cell.textLabel setTextColor:getUIColor(0x26231E)];
    [cell.textLabel setFont:[UIFont regulerApplicationFontOfSize:font(15)]];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DRZQListViewController *ZQController = [[DRZQListViewController alloc] init];
    [self.navigationController pushViewController:ZQController animated:YES];
}

@end
