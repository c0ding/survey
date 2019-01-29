//
//  DRIntelligentAnalysisQuestionView.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/9.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRIntelligentAnalysisQuestionView.h"

# define tableViewH 246
@interface DRIntelligentAnalysisQuestionView()<UITableViewDelegate, UITableViewDataSource>
///早上好
@property (nonatomic ,strong)UILabel *toplabel;
///智能风控结果由大数据算法生成，仅供参考。
@property (nonatomic ,strong)UILabel *toplabe2;
@property (nonatomic ,strong)DRBaseTableView *tableView;
@end

@implementation DRIntelligentAnalysisQuestionView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.toplabel.text = [NSString timeWithTimeIntervalStringHavehh];
        [self toplabe2];
        [self tableView];
        
        
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    DRIntelligentAnalysisQuestionModel * model =  self.dataSource[indexPath.row];
    cell.textLabel.text = model.question;
    cell.textLabel.textColor = [UIColor colorWithString:@"#5092FF"];
    cell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:font(17)];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndexPathWithModel:AndIndexPath:)]) {
        [self.delegate didSelectRowAtIndexPathWithModel:self.dataSource[indexPath.row] AndIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (DRBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[DRBaseTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_toplabe2.frame)+kHeight(10), kScreenWidth, kHeight(tableViewH)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
        [self addSubview:_tableView];
        
    }
    return _tableView;
}
- (UILabel *)toplabel {
    if (!_toplabel) {
        _toplabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(20), kHeight(28), kWidth(153), kHeight(48))];
        _toplabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:font(34)];
        _toplabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1/1.0];
        [self addSubview:_toplabel];
    }
    return _toplabel;
}
- (UILabel *)toplabe2 {
    if (!_toplabe2) {
        _toplabe2 = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(20), CGRectGetMaxY(_toplabel.frame) + kHeight(7), kWidth(320), kHeight(21))];
        _toplabe2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:font(15)];
        _toplabe2.text = @"智能风控结果由大数据算法生成，仅供参考。";
        _toplabe2.textColor = [UIColor colorWithRed:116/255.0 green:116/255.0 blue:116/255.0 alpha:1/1.0];
        [self addSubview:_toplabe2];
    }
    return _toplabe2;
}
@end
