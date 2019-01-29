//
//  DRTermsExplanationViewController.m
//  SPV
//
//  Created by 张逸阳 on 2018/1/5.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRTermsExplanationViewController.h"
#import "DRTermsExplanationCell.h"
#import "DRSallyTableViewCell.h"
#import "DRIntelligentAnalysisQuestionView.h"
#import "DRIntelligentAnalysisQuestionModel.h"
#import "DRDialogueCell.h"
# define headerH 350
@interface DRTermsExplanationViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIScrollViewDelegate,DRIntelligentAnalysisQuestionViewDelegate>
@property (nonatomic ,strong) DRIntelligentAnalysisQuestionView *headerView;
@property (nonatomic ,strong) DRBaseTableView *tableView;
@property (nonatomic ,strong) NSMutableArray<DRIntelligentAnalysisQuestionModel*> *dataSource;

@property (nonatomic ,strong) NSMutableArray<DRDialogueModel*> *msgDataSource;
@property (nonatomic ,strong) UIView *footView;

@end
static NSString *identify = @"DRDialogueCell";
@implementation DRTermsExplanationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"智能风控说明";
    UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [buttonBack setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [buttonBack setImage:[UIImage imageNamed:@"BackGray"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    [buttonBack addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    //读取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IntelligentControlInstructions" ofType:@"plist"];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:path];
    self.dataSource = [NSMutableArray arrayWithCapacity:12];
    self.msgDataSource = [NSMutableArray arrayWithCapacity:12];
    for (NSDictionary *obj in arr) {
        [self.dataSource addObject:[DRIntelligentAnalysisQuestionModel mj_objectWithKeyValues:obj]];
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kHeight(64), 0);
    [self.view addSubview: self.tableView];
    self.headerView.dataSource = [NSMutableArray arrayWithArray:self.dataSource];
    [self.tableView registerClass:[DRDialogueCell class] forCellReuseIdentifier:identify];
}


-(void)viewDidDisappear:(BOOL)animated {
    self.navigationController.delegate = nil;
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.msgDataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kHeight(headerH);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DRDialogueModel *model = self.msgDataSource[indexPath.row];
    CGRect rec =  [model.msg boundingRectWithSize:CGSizeMake(kWidth(225), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font(16)]} context:nil];
    return rec.size.height + kHeight(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DRDialogueCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.model = self.msgDataSource[indexPath.row];
    return cell;
}

- (void)didSelectRowAtIndexPathWithModel:(DRIntelligentAnalysisQuestionModel *)model AndIndexPath:(NSIndexPath *)indexPath {
    DRDialogueModel *dialogueModelQ = [[DRDialogueModel alloc] init];
    dialogueModelQ.msg = model.question;
    dialogueModelQ.isRight = YES;
    
    DRDialogueModel *dialogueModelA = [[DRDialogueModel alloc] init];
    dialogueModelA.msg = model.anwser;
    dialogueModelA.isRight = NO;
    
    [self.msgDataSource addObject:dialogueModelQ];
    [self.msgDataSource addObject:dialogueModelA];
    [self.tableView reloadData];
    if (self.msgDataSource.count != 0) {
        double delayInSeconds = 0.2;//延迟滚动，否则无法准确滚动到最后一行
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.msgDataSource.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        });
    }
}



#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:!isShowHomePage animated:YES];
}
-(void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (DRBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[DRBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-10) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}
- (DRIntelligentAnalysisQuestionView *)headerView {
    if (!_headerView) {
        _headerView = [[DRIntelligentAnalysisQuestionView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.delegate = self;
    }
    return _headerView;
}
- (UIView *)footView {
    if (!_footView) {
        _footView = ({
            UIView *view = [[UIView alloc] init];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, kHeight(65))];
            [label setText:@"智能风控结果由大数据算法生成，仅供参考"];
            [label setTextColor:RGB(155, 155, 155)];
            [label setFont:[UIFont LightapplicationFontOfSize:12]];
            [label setNumberOfLines:0];
            [label setTextAlignment:NSTextAlignmentCenter];
            [view setBackgroundColor:RGB(245, 245, 245)];
            [view addSubview:label];
            [self.view addSubview:view];
            view;
        });
    }
    return _footView;
}




//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [buttonBack setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
//    [buttonBack setImage:[UIImage imageNamed:@"BackGray"] forState:UIControlStateNormal];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonBack];
//    [buttonBack addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//
//    NSArray *A = @[
//                      @{@"terms":@"『 长期 』",@"explanation":@"建议长期持有，抵押资产可覆盖3年以上的债权增长；"},
//                      @{@"terms":@"『 中期 』",@"explanation":@"建议中期持有，抵押资产可覆盖1-3年的债权增长；"},
//                      @{@"terms":@"『 观望 』",@"explanation":@"建议观望抵押物价值变化，抵押资产仅可覆盖1年内的债权增长；"},
//                      @{@"terms":@"『 关注 』",@"explanation":@"建议关注抵押物价值变化，抵押资产无法覆盖债权增长；"},
//                      @{@"terms":@"『 出售 』",@"explanation":@"建议立即出售，抵押资产无法覆盖资金成本。"}
//                      ];
//
//
//    NSArray *B = @[
//                           @{@"terms":@"『 A+ 』",@"explanation":@"可覆盖3年以上的资金成本；"},
//                           @{@"terms":@"『 A 』",@"explanation":@"可覆盖1-3年的资金成本；"},
//                           @{@"terms":@"『 B 』",@"explanation":@"可覆盖3个月到1年的资金成本；"},
//                           @{@"terms":@"『 C 』",@"explanation":@"可覆盖1-3个月的资金成本；"},
//                           @{@"terms":@"『 D 』",@"explanation":@"小于资金成本。"}
//                           ];
//
//
//    NSArray *C = @[
//                          @{@"imageName":@"green_up",@"explanation":@"抵押资产再次覆盖债权增长，风险降低；"},
//                          @{@"imageName":@"green_down",@"explanation":@"抵押资产无法覆盖债权增长，风险增加；"},
//                          @{@"imageName":@"white_up",@"explanation":@"债权增长再次覆盖资金成本，亏损减轻；"},
//                          @{@"imageName":@"white_down",@"explanation":@"债权增长无法覆盖资金成本，亏损加重。"}
//                          ];
//
//    NSArray *D =  @[
//                    @{@"terms":@"『 抵押资产 』",@"explanation":@"抵押物实时价值，由大数据智能算法自动生成；"},
//                    @{@"terms":@"『 债权增长 』",@"explanation":@"债权价值，由剩余本金以及每日增长的利息、罚息累计而成；"},
//                    @{@"terms":@"『 资金成本 』",@"explanation":@"投资的资金成本，由投资金额和约定的资金成本率计算而成。"}
//                    ];
//
//
//
//    if ([self.type isEqualToString:@"A"]) {
//        self.title = @"交易策略";
//        self.dataSource = [NSMutableArray arrayWithArray:A];
//    }else if ([self.type isEqualToString:@"B"]) {
//        self.title = @"风险评级";
//        self.dataSource = [NSMutableArray arrayWithArray:B];
//    }else if ([self.type isEqualToString:@"C"]){
//        self.title = @"突破";
//        self.dataSource = [NSMutableArray arrayWithArray:C];
//    }else if ([self.type isEqualToString:@"D"]){
//        self.title = @"数据介绍";
//        self.dataSource = [NSMutableArray arrayWithArray:D];
//    }
//
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kHeight(64), 0);
//
//    [self.view addSubview: self.tableView];
//    [self footView];
//
//     NSString *path = [[NSBundle mainBundle] pathForResource:@"IntelligentControlInstructions" ofType:@"plist"];
//    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:path];
//    NSDictionary *dict = arr[0];
//
//
//}
//
//-(void)backClick
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataSource.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self.type isEqualToString:@"C"] ) {
//        //突破
//        return [DRTermsExplanationCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//            DRSallyTableViewCell *cell = (DRSallyTableViewCell *)sourceCell;
//            [cell setupValueWithArray:self.dataSource andIndexPath:indexPath];
//        }];
//
//
//    }else {
//        //策略\风险\介绍
//        return [DRTermsExplanationCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//
//            DRTermsExplanationCell *cell = (DRTermsExplanationCell*)sourceCell;
//
//            [cell setupValueWithArray:self.dataSource andIndexPath:indexPath];
//
//        }];
//    }
//}
//
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self.type isEqualToString:@"C"]) {
//        //突破
//        DRSallyTableViewCell *cell =  [[DRSallyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setupValueWithArray:self.dataSource andIndexPath:indexPath];
//
//
//        return cell;
//    }else {
//        //策略／风险／介绍
//        DRTermsExplanationCell *cell =  [[DRTermsExplanationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setupValueWithArray:self.dataSource andIndexPath:indexPath];
//
//        return cell;
//    }
//
//}
//#pragma mark - UINavigationControllerDelegate
//// 将要显示控制器
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:!isShowHomePage animated:YES];
//}
//
//#pragma -mark 系统方法
//
//-(void)viewDidDisappear:(BOOL)animated
//{
//    self.navigationController.delegate = nil;
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    self.navigationController.delegate = self;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//}
//
//- (DRBaseTableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[DRBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kHeight(65)) style:UITableViewStylePlain];
//
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
//    }
//    return _tableView;
//}
//
//
//
//
//
//
//- (UIView *)footView {
//    if (!_footView) {
//        _footView = ({
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame)-64, kScreenWidth, kHeight(65))];
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, kHeight(65))];
//            [label setText:@"智能风控结果由大数据算法生成，仅供参考"];
//            [label setTextColor:RGB(155, 155, 155)];
//            [label setFont:[UIFont LightapplicationFontOfSize:12]];
//            [label setNumberOfLines:0];
//            [label setTextAlignment:NSTextAlignmentCenter];
//            [view setBackgroundColor:RGB(245, 245, 245)];
//            [view addSubview:label];
//            [self.view addSubview:view];
//            view;
//        });
//    }
//    return _footView;
//}

@end
