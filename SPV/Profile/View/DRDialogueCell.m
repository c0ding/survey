//
//  DRDialogueCell.m
//  SPV
//
//  Created by 张逸阳 on 2018/5/10.
//  Copyright © 2018年 hejiahuan. All rights reserved.
//

#import "DRDialogueCell.h"

@implementation DRDialogueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.backView];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:font(15)];
        [self.backView addSubview:self.contentLabel];
    }
    return self;
}

- (void)setModel:(DRDialogueModel *)model {
    // 首先计算文本宽度和高度
    CGRect rec = [model.msg boundingRectWithSize:CGSizeMake(kWidth(225), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font(16)]} context:nil];
    // 气泡
    UIImage *image = nil;
    // 模拟左边
    if (!model.isRight) {
        // 当输入只有一个行的时候高度就是24
        self.backView.frame = CGRectMake(kWidth(20), 10, rec.size.width + kWidth(32), rec.size.height + kHeight(24));
        image = [UIImage imageNamed:@"bubbleSomeone"];
        
    }
    else {
        // 模拟右边
        self.backView.frame = CGRectMake(kScreenWidth - kWidth(40)-rec.size.width, 10, rec.size.width + kWidth(32), rec.size.height + kHeight(24));
        image = [UIImage imageNamed:@"bubbleMine"];
        
    }
    // 拉伸图片 参数1 代表从左侧到指定像素禁止拉伸，该像素之后拉伸，参数2 代表从上面到指定像素禁止拉伸，该像素以下就拉伸
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    self.backView.image = image;
//    self.headImageView.image = headImage;
    // 文本内容的frame
    self.contentLabel.frame = CGRectMake(model.isRight ? kWidth(16) : kWidth(16), kHeight(12), rec.size.width, rec.size.height);
    self.contentLabel.textColor = model.isRight?[UIColor whiteColor]:[UIColor colorWithString:@"#4A4A4A"];
    
    self.contentLabel.text = model.msg;
    [self setLabelAttributes:model.msg isRightLabel:model.isRight];
//    [self setLabelAttributes:model.msg];
    
}
- (void)setLabelAttributes:(NSString *)str isRightLabel:(BOOL)isRightLabel{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]
                                          initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:
     [UIFont boldSystemFontOfSize:font(16)] range:NSMakeRange(0, 4)];  //字体大小为18.0f并且加粗
    
    if (!isRightLabel) {
        self.contentLabel.attributedText = attrStr;
    }
    
}



@end
