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
#import "DRCollectCellB.h"
#import "DRCollectCellC.h"
#import "DRCollectCellD.h"
#import "DRCollectSheetMainView.h"
#import "DRDatePicker.h"

#import "DRKeyboardTextView.h"
@interface DRCollectVC ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UIView *maskView;
@property (nonatomic ,strong)DRCollectSheetMainView *collectSheetMainView;
@property (nonatomic ,strong)DRCollectNavView *collectNavView;
@property (nonatomic ,strong)DRDropMainView *dropMainView;
@property (nonatomic ,strong)DRKeyboardTextView *keyboardTextView;
@property (nonatomic ,strong)DRBaseTableView *tableView;
@property (nonatomic ,strong) NSArray<NSString*>*sectionHTittles;

@property (nonatomic ,strong) DRCollectGetModel *collectGetModel;
@property (nonatomic ,strong) NSString *currentText;//当前编辑的文本
@property (nonatomic ,strong) NSIndexPath *currentIndexPath;//当前选择的行
@property (nonatomic ,strong) DataModel *currentDataModel;//对选择的对象进行修改


@end

@implementation DRCollectVC

- (void)keyboardWillShow:(NSNotification *)info
{
    CGRect keyboardBounds = [[[info userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _tableView.contentInset = UIEdgeInsetsMake(_tableView.contentInset.top, 0, keyboardBounds.size.height, 0);
    
    
}
- (void)keyboardWillHide:(NSNotification *)info
{
    _tableView.contentInset = UIEdgeInsetsMake(_tableView.contentInset.top, 0, 0, 0);
    
}

- (void)show {
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = -110;
    [self.view bringSubviewToFront:self.keyboardTextView];
    [self.keyboardTextView.textView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self.view addSubview:self.keyboardTextView];
    
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
        DRBaseTableView *view = [[DRBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
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
    
    
    CGFloat leftLabH = [dataModel.name?:@"1行" boundingRectWithSize:CGSizeMake(kWidth(60), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:font(labFont)]} context:nil].size.height;
    
    if (leftLabH > rightLabH) {
        return leftLabH + topMargin + bottomMargin;
    }

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
    if (section == 0) {
        return  _collectGetModel.data.dataList.count;
    }else if (section == 1) {
        return 3;
    }else {
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        DRCollectCellA *cell = [[DRCollectCellA alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        
        
        return cell;
        
        
    }else if (indexPath.section == 2) {
        
        DRCollectCellA *cell = [[DRCollectCellA alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        
        
        return cell;
        
        
    }
    else {
        DataModel *dataModel = _collectGetModel.data.dataList[indexPath.row];
        switch (dataModel.type) {
            case 1: {
                DRCollectCellA *cell = [[DRCollectCellA alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                cell.leftTittle = dataModel.name;
                cell.rightTittle = dataModel.content;
                return cell;
            }
            case 2: {
                self.keyboardTextView.textView.keyboardType = UIKeyboardTypeNumberPad;
                DRCollectCellB *cell = [[DRCollectCellB alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                cell.leftTittle = dataModel.name;
                cell.rightTittle = dataModel.content;
                cell.danweiTittle = @"平方米";
                return cell;
            }
            case 3: {
                self.keyboardTextView.textView.keyboardType = UIKeyboardTypeNumberPad;
                DRCollectCellC *cell = [[DRCollectCellC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                cell.leftTittle = dataModel.name?:@"土地面积";
                cell.rightTittle = dataModel.content;
                cell.coverTittle = @"等价于0亩";
                return cell;
            }
            case 4: {
                DRCollectCellC *cell = [[DRCollectCellC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                cell.leftTittle = dataModel.name;
                cell.rightTittle = dataModel.content;
                cell.coverTittle = @"剩余20年11个月21天";
                return cell;
            }
            case 5: {
                DRCollectCellA *cell = [[DRCollectCellA alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                cell.leftTittle = dataModel.name;
                cell.rightTittle = dataModel.content;
                return cell;
                break;
            }
            case 6: {
                DRCollectCellA *cell = [[DRCollectCellA alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                for (SelectModel*selectModel in dataModel.select) {
                    if ([selectModel.key isEqualToString:dataModel.content]) {
                        cell.rightTittle = selectModel.value;
                        break;
                    }
                    cell.rightTittle = @"无数据";
                }
                cell.leftTittle = dataModel.name;
                return cell;
                
            }
            case 7: {
                DRCollectCellA *cell = [[DRCollectCellA alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                for (SelectModel*selectModel in dataModel.select) {
                    if ([selectModel.key isEqualToString:dataModel.content]) {
                        cell.rightTittle = selectModel.value;
                        break;
                    }
                    cell.rightTittle = @"无数据";
                }
                cell.leftTittle = dataModel.name;
                return cell;
                
            }
            case 8: {
                DRCollectCellD *cell = [[DRCollectCellD alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                cell.leftTittle = dataModel.name;
                
                NSMutableArray *arr = [NSMutableArray array];
                for (AttachmentModel *model in dataModel.attachmentList) {
                    [arr addObject:model.name];
                }
                cell.contents = arr;
                cell.clickBlock = ^(NSInteger index) {
                    NSLog(@"%@",dataModel.attachmentList[index].url);
                };
                return cell;
                break;
            }
                
            case 9: {
                // 备注行
                break;
            }
                
            case 10: {
                // 暂无此类型
                break;
            }
        }
        
        
        
        
        
        
        if (dataModel.type == 6) {
            
        }
        
        DRCollectCellA *cell = [[DRCollectCellA alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        return cell;
    }
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DataModel *dataModel = _collectGetModel.data.dataList[indexPath.row];
        self.currentIndexPath = indexPath;
        self.currentDataModel = dataModel;
        switch (dataModel.type) {
                
            case 1:{
                [self show];
                break;
            }
            case 2:{
                [self show];
                break;
            }
            case 3:{
                [self show];
                break;
            }
            case 4:{
                DRDatePicker* datePicker= [[DRDatePicker alloc]initWithFrame:self.view.frame];
                datePicker.title = @"使用年限";
                datePicker.dateChooseCallBack = ^(NSString * _Nonnull date) {
                    NSLog(@"%@",date);
                };
                [datePicker show];
                break;
            }

            case 5:{
                DRDatePicker* datePicker= [[DRDatePicker alloc]initWithFrame:self.view.frame];
                datePicker.title = @"建成日期";
                datePicker.dateChooseCallBack = ^(NSString * _Nonnull date) {
                    NSLog(@"%@",date);
                };
                [datePicker show];
                break;
            }
                
            case 6:{
                [self didType6WithIndex:indexPath];
                break;
            }
            case 7:{
                NSMutableArray *arr = [NSMutableArray array];
                for (int i =0; i<2; i++) {
                    SelectModel*selectModel = [[SelectModel alloc] init];
                    selectModel.key = i==0?@"0":@"1";
                    selectModel.value = i==0?@"否":@"是";
                    [dataModel.select addObject:selectModel];
                    [arr addObject:selectModel.value];
                }
                
                
                
                
                DRCollectSheetMainView *collectSheetMainView = [[DRCollectSheetMainView alloc] initWithFrame:self.view.frame];
                collectSheetMainView.contents = arr;
                [collectSheetMainView show];
                collectSheetMainView.tittle = dataModel.name;
                
                // 查询当前选择
                for (int i=0; i<dataModel.select.count; i++) {
                    SelectModel *selectModel = dataModel.select[i];
                    if ([dataModel.content isEqualToString:selectModel.key]) {
                        collectSheetMainView.currertSlectIndex = i;
                        break;
                    }
                }
                collectSheetMainView.sheetMainBlock = ^(NSInteger index, NSString * _Nonnull text) {
                    NSLog(@"当前选中了第%ld个对象，内容：%@",index,text);
                    // 更改选择
                    SelectModel *selectModel = dataModel.select[index];
                    dataModel.content = selectModel.key;
                    
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                };
                break;
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didType6WithIndex:(NSIndexPath *)indexPath {
    NSMutableArray *arr = [NSMutableArray array];
    for (SelectModel*selectModel in self.currentDataModel.select) {
        [arr addObject:selectModel.value];
        
    }
    DRCollectSheetMainView *collectSheetMainView = [[DRCollectSheetMainView alloc] initWithFrame:self.view.frame];
    collectSheetMainView.contents = arr;
    [collectSheetMainView show];
    collectSheetMainView.tittle = self.currentDataModel.name;
    
    // 查询当前选择
    for (int i=0; i<self.currentDataModel.select.count; i++) {
        SelectModel *selectModel = self.currentDataModel.select[i];
        if ([self.currentDataModel.content isEqualToString:selectModel.key]) {
            collectSheetMainView.currertSlectIndex = i;
            break;
        }
    }
    collectSheetMainView.sheetMainBlock = ^(NSInteger index, NSString * _Nonnull text) {
        NSLog(@"当前选中了第%ld个对象，内容：%@",index,text);
        // 更改选择
        SelectModel *selectModel = self.currentDataModel.select[index];
        self.currentDataModel.content = selectModel.key;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    };
}

- (UIView *)maskView {
    if (!_maskView) {
        UIView *view = [[UIView alloc] initWithFrame:_tableView.frame];
        
        view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7172214673913043/1.0];
        view.alpha = 0;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        WEAKSELF
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [weakSelf showDropMainView:NO];
        }];
        [view addGestureRecognizer:tap];
        
        _maskView = view;
    }
    return _maskView;
}


- (DRKeyboardTextView *)keyboardTextView {
    if (!_keyboardTextView) {
        _keyboardTextView = [[DRKeyboardTextView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 49)];
        _keyboardTextView.backgroundColor = [UIColor blackColor];
        _keyboardTextView.alpha = 0.3;
        [_keyboardTextView setPlaceholderText:@"请输入文字"];
        WEAKSELF
        _keyboardTextView.TextBlcok = ^(NSString * _Nonnull text) {
            NSLog(@"%@",text);
            weakSelf.currentText = text;
            weakSelf.currentDataModel.content = text;
            [weakSelf.tableView reloadData];
        };
    }
    return _keyboardTextView;
}
@end
