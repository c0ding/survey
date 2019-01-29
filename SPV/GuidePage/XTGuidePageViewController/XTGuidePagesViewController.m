//
//  XTGuidePagesViewController.m
//  XTGuidePagesView
//
//  Created by zjwang on 16/5/30.
//  Copyright © 2016年 夏天. All rights reserved.
//

#import "XTGuidePagesViewController.h"
#import "DRGuidePageFirst.h"
#import "DRGuidePageSecond.h"
#import "DRGuidePageThird.h"
#import "DRGuidePageFour.h"
#define s_w [UIScreen mainScreen].bounds.size.width
#define s_h [UIScreen mainScreen].bounds.size.height
#define VERSION_INFO_CURRENT @"currentversion"
@interface XTGuidePagesViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) DRGuidePageFirst *firstView;
@property (nonatomic, strong) DRGuidePageSecond *secondView;
@property (nonatomic, strong) DRGuidePageThird *thirdView;
@property (nonatomic, strong) DRGuidePageFour *fourView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation XTGuidePagesViewController
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVersion:) name:kToUpdateNotification object:nil];
}

- (void)updateVersion:(NSNotification *)note {
    DRUpdateVersionModel *data = (DRUpdateVersionModel*)note.object;
    if (data.obj.force == YES) {
        [self toUpdateWithDRUpdateVersionModel:data];
    }
//    [self toUpdateWithDRUpdateVersionModel:data];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter ] removeObserver:self name:kToUpdateNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver];
}




- (void)guidePageControllerWithImages:(NSArray *)images
{
    UIScrollView *gui = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    gui.delegate = self;
    UIImageView *guiBgView = [[UIImageView alloc] initWithImage:kGetImage(@"GuidePage_bg")];
    [gui addSubview:guiBgView];
    
    gui.delegate = self;
    gui.pagingEnabled = YES;
    // 隐藏滑动条
    gui.showsHorizontalScrollIndicator = NO;
    gui.showsVerticalScrollIndicator = NO;
    // 取消反弹
    gui.bounces = NO;
    for (NSInteger i = 0; i < images.count; i ++) {
        
        
        UIImage *img = kGetImage(images[i]);
//        CGFloat top = img.size.height * 0.5;
//        CGFloat left = img.size.width * 0.5;
//        CGFloat bottom = img.size.height * 0.5;
//        CGFloat right = img.size.width * 0.5;
//
//        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//
//        UIImage *newImg = [img resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        [gui addSubview:({
            self.btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnEnter.frame = CGRectMake(s_w * i, 0, s_w, s_h);
            [self.btnEnter setBackgroundImage:img forState:UIControlStateNormal];
            [self.btnEnter setBackgroundImage:img forState:UIControlStateHighlighted];
            
            
            self.btnEnter;
        })];

        if (i ==  0) {
            DRGuidePageFirst *firstView = [[DRGuidePageFirst alloc] initWithFrame:CGRectMake(0, KIsiPhoneX?84:64, kScreenWidth, kHeight(300))];
            self.firstView = firstView;
            [self.btnEnter addSubview:firstView];
            [self.firstView startAnimation];
        }
        
        if (i == 1) {
            DRGuidePageSecond *secondView = [[DRGuidePageSecond alloc] initWithFrame:CGRectMake(0, KIsiPhoneX?84:64, kScreenWidth, kHeight(300))];
            self.secondView = secondView;
            [self.btnEnter addSubview:secondView];
        }
        
        if (i == 2) {
            DRGuidePageThird *thirdView = [[DRGuidePageThird alloc] initWithFrame:CGRectMake(0, KIsiPhoneX?84:64, kScreenWidth, kHeight(300))];
            self.thirdView = thirdView;
            [self.btnEnter addSubview:self.thirdView];
        }
        
        if (i == 3) {
            DRGuidePageFour *fourView = [[DRGuidePageFour alloc] initWithFrame:CGRectMake(0, KIsiPhoneX?84:64, kScreenWidth, kHeight(300))];
            self.fourView = fourView;
            [self.btnEnter addSubview:self.fourView];
        }
        
        
        
        
        if (i == images.count - 1) {
            [self.btnEnter addSubview:({
                //最后一页显示 立即体验按钮
                UIButton *immediateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                immediateBtn.frame = CGRectMake(0, 0, kWidth(156) , KIsiPhoneX?80:kHeight(70));
                
                immediateBtn.center = CGPointMake(s_w*0.5, s_h - 70);
                
                immediateBtn.clipsToBounds = YES;
                [immediateBtn addTarget:self action:@selector(clickEnter) forControlEvents:UIControlEventTouchUpInside];
                
                NSString *imageStr = KIsiPhoneX?@"GuidePage_button_nx":@"GuidePage_button_n";
                [immediateBtn setBackgroundImage:kGetImage(imageStr) forState:UIControlStateNormal];
                [immediateBtn setBackgroundImage:kGetImage(imageStr) forState:UIControlStateHighlighted];
                
                immediateBtn;
            })];
        }
        
        if (i != images.count - 1) {
            //跳过按钮
            [self.btnEnter addSubview:({
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:@"跳过" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:font(15)]];
                [btn setTintColor:[UIColor whiteColor]];
                btn.frame = CGRectMake(0, 0, 50, 40);
                btn.center = CGPointMake(s_w - 50, KIsiPhoneX?kHeight(90):kHeight(70));
                [btn addTarget:self action:@selector(clickEnter) forControlEvents:UIControlEventTouchUpInside];
                btn;
            })];
        }

    }
    gui.contentSize = CGSizeMake(s_w * images.count,0);
    guiBgView.frame = gui.frame;
    guiBgView.size = CGSizeMake(gui.contentSize.width, s_h);
    [self.view addSubview:gui];
    
//    // pageControl
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, s_w / 2, kHeight(50))];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidden = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithString:@"#e0f1ff"];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.center = CGPointMake(s_w / 2, s_h - kHeight(210));
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
//    [self setupTopAnimationViewWithIndex:self.pageControl.currentPage];
}


- (void)clickEnter
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickEnter)]) {
        [self.delegate clickEnter];
    }
}
+ (BOOL)isShow
{
    // 读取版本信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [user objectForKey:VERSION_INFO_CURRENT];
    NSString *currentVersion =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (localVersion == nil || ![currentVersion isEqualToString:localVersion]) {
        [XTGuidePagesViewController saveCurrentVersion];
        return YES;
    }else
    {
        return NO;
    }
}
// 保存版本信息
+ (void)saveCurrentVersion
{
    NSString *version =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:version forKey:VERSION_INFO_CURRENT];
    [user synchronize];
}
#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.pageControl.currentPage == scrollView.contentOffset.x / s_w) {
        return;
    }
    
    self.pageControl.currentPage = scrollView.contentOffset.x / s_w;

    if (self.pageControl.currentPage == 0) {
        [self.firstView startAnimation];
    }else {
        [self.firstView stopAnimation];
        
    }
    
    if (self.pageControl.currentPage == 1) {
        [self.secondView startAnimation];
    }else {
        [self.secondView stopAnimation];
    }

    if (self.pageControl.currentPage == 2) {
        [self.thirdView startAnimation];
    }else {
        [self.thirdView stopAnimation];
    }
    
    if (self.pageControl.currentPage == 3) {
        [self.fourView startAnimation];
    }else {
        [self.fourView stopAnimation];
    }
    
}





@end


