//
//  DRCollectVC.m
//  SPV
//
//  Created by 张逸阳 on 2019/2/13.
//  Copyright © 2019年 训机. All rights reserved.
//

#import "DRCollectVC.h"
#import "DRCollectNavView.h"
#import "DRDropMainView.h"
#import "DRCollectCellA.h"
@interface DRCollectVC ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UIView *maskView;

@property (nonatomic ,strong)DRCollectNavView *collectNavView;
@property (nonatomic ,strong)DRDropMainView *dropMainView;

@property (nonatomic ,strong)DRBaseTableView *tableView;
@property (nonatomic ,strong) NSArray<NSString*>*sectionHTittles;

@property (nonatomic ,strong) DRCollectGetModel *collectGetModel;
@end

@implementation DRCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [[DRMockData shareDRMockData] collectGet];
    _collectGetModel = [DRCollectGetModel mj_objectWithKeyValues: dict ];
    
    _sectionHTittles = @[@"项目描述",@"实地定位",@"实地拍摄"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_StatusBar)];
    statusView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statusView];
    _collectNavView = [[DRCollectNavView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(statusView.frame), kScreenWidth, kHeight(44))];
    [self.view addSubview:_collectNavView];
    WEAKSELF
    _collectNavView.leftClickBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    _collectNavView.rightClickBlock = ^{
        NSLog(@"保存");
    };
    
    _collectNavView.centerClickBlock = ^{
        [weakSelf showDropMainView:YES];
    };
    
    
    _dropMainView = ({
        DRDropMainView *view = [[DRDropMainView alloc] init];
        view.frame = CGRectMake(0, CGRectGetMaxY(_collectNavView.frame), kScreenWidth, kRowH*kRowCount);
        view.height = 0;
        
        [self.view addSubview:view];
        view;
    });
    _dropMainView.currertSelect = 2;
    _dropMainView.dropMainBlock = ^(NSInteger index, NSString *text) {
        NSLog(@"当前选择了： %ld",index);
        weakSelf.collectNavView.text = text;
        [weakSelf showDropMainView:NO];
    };
    
    _tableView = ({
        DRBaseTableView *view = [[DRBaseTableView alloc] init];
        view.delegate = self;
        view.dataSource = self;
        CGFloat y = CGRectGetMaxY(_collectNavView.frame);
        view.frame = CGRectMake(0, y, kScreenWidth, kScreenHeight - y);
        view.backgroundColor = [UIColor whiteColor];
        view.sectionHeaderHeight = kHeight(34);
        view.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
        view.sectionFooterHeight = kHeight(9);
        [self.view addSubview:view];
        view;
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)showDropMainView:(BOOL)isShow {
    _tableView.userInteractionEnabled = !isShow;
    WEAKSELF
    if (isShow) {
        [self.view addSubview:self.maskView];
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.dropMainView.height = kRowH*kRowCount;
            _tableView.y = CGRectGetMaxY(weakSelf.dropMainView.frame);
            weakSelf.maskView.frame = _tableView.frame;
            weakSelf.maskView.alpha = 0.7;
        }];
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            _dropMainView.height = 0;
            _tableView.y = CGRectGetMaxY(_collectNavView.frame);
            [weakSelf.collectNavView showBtn:isShow];
            weakSelf.maskView.alpha = 0;
            [weakSelf.maskView removeFromSuperview];
            weakSelf.maskView = nil;
            
        }];
    }
    [self.collectNavView showBtn:isShow];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    DataModel *dataModel = _collectGetModel.data.dataList[indexPath.row];
    

    CGFloat rightLabH = [dataModel.content?:@"1行" boundingRectWithSize:CGSizeMake(labW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:font(labFont)]} context:nil].size.height;

    return rightLabH + topMargin + bottomMargin;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGB(242, 242, 242);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    label.text = _sectionHTittles[section];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font(13)];
    label.textColor = RGB(38, 35, 30);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kWidth(16));
    }];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionHTittles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _collectGetModel.data.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DRCollectCellA *cell = [[DRCollectCellA alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    DataModel *dataModel = _collectGetModel.data.dataList[indexPath.row];
    cell.leftTittle = dataModel.name;
    cell.rightTittle = dataModel.content;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

- (UIView *)maskView {
    if (!_maskView) {
        UIView *view = [[UIView alloc] initWithFrame:_tableView.frame];
        
        view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7172214673913043/1.0];
        view.alpha = 0;
        
        _maskView = view;
    }
    return _maskView;
}

@end
