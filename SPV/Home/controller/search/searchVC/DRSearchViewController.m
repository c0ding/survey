//
//  DRSearchViewController.m
//  SPV
//
//  Created by 黄梦炜 on 2019/2/15.
//  Copyright © 2019 hejiahuan. All rights reserved.
//

#import "DRSearchViewController.h"
#import "PYSearch.h"


@interface DRSearchViewController () <PYSearchViewControllerDelegate>

@end

@implementation DRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set title
    self.title = @"PYSearchExampleController";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 5 : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (indexPath.section == 0) { // 选择热门搜索风格
        cell.textLabel.text = @[@"PYHotSearchStyleDefault", @"PYHotSearchStyleColorfulTag", @"PYHotSearchStyleBorderTag", @"PYHotSearchStyleARCBorderTag", @"PYHotSearchStyleRankTag", @"PYHotSearchStyleRectangleTag"][indexPath.row];
    } else { // 选择搜索历史风格
        cell.textLabel.text = @[@"PYSearchHistoryStyleDefault", @"PYSearchHistoryStyleNormalTag", @"PYSearchHistoryStyleColorfulTag", @"PYSearchHistoryStyleBorderTag", @"PYSearchHistoryStyleARCBorderTag"][indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程语言" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
//        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. 设置风格
    if (indexPath.section == 0) { // 选择热门搜索
        searchViewController.hotSearchStyle = (NSInteger)indexPath.row; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    } else { // 选择搜索历史
        searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
        searchViewController.searchHistoryStyle = (NSInteger)indexPath.row; // 搜索历史风格根据选择
    }
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? @"选择搜索历史风格（热门搜索为默认风格）" : @"选择热门搜索风格（搜索历史为默认风格）";
}

#pragma mark - PYSearchViewControllerDelegate
//- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
//{
//    if (searchText.length) { // 与搜索条件再搜索
//        // 根据条件发送查询（这里模拟搜索）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
//            // 显示建议搜索结果
//            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
//            // 返回
//            searchViewController.searchSuggestions = searchSuggestionsM;
//        });
//    }
//}
@end
