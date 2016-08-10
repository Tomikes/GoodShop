//
//  HomeViewController.m
//  GoodShop
//
//  Created by mike on 5/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchTextFiled.h"
#import "VoiceSearchIconView.h"
#import <pop/POP.h>
#import "MS_RefreshGifHeader.h"
#import "MSAutoScrollView.h"
#import "MainPageTableViewController.h"
#import "ScanViewController.h"
#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0
static NSString * const mainPageTableCellId = @"cell";

@interface HomeViewController () <UITextFieldDelegate, SearchBarDelegate,VoiceSearchIconDelegate,MSAutoScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MainPageTableViewController *pageController;

@property (nonatomic, weak) SearchTextFiled     *searchTextFiled;
@property (nonatomic, weak) VoiceSearchIconView *voiceView;
@property (nonatomic, strong) MSAutoScrollView *lunBoView;

@end

@implementation HomeViewController
@synthesize pageController = _pageController;
@synthesize searchTextFiled = _searchTextFiled;
@synthesize voiceView       = _voiceView;

- (void)loadView
{
    [super loadView];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GS_Whitle;

    [self setRightNarBarItem];
    [self addMainPge];
    [self setLunboDataSource];
    [self setNavgationTheme];
    
//    self.pageController.tableView.tableFooterView = [[UIView alloc] init];    //不显示空的cell
    [self.pageController.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//   [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.searchTextFiled resignFirstResponder];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)setNavgationTheme{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.navigationItem.titleView = self.searchTextFiled;
    //动态该表nav的颜色
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithWhite:1 alpha:0.7]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //每当值改变就调用action方法
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
    CGPoint newPoint = [[change objectForKey:@"new"] CGPointValue];
        CGFloat i = newPoint.y;
        
        if (i <= 0) {
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        }else if (0 <i && i <=30 ){
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:i/30];
        } else{
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];

        }
    }
   
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}
#pragma MARK:setRightNarBarItem
- (void)setRightNarBarItem{
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    v1.backgroundColor = [UIColor clearColor];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, 25, 25)];
  
    imgv.image = [UIImage imageNamed:@"Barcode"];
    imgv.contentMode = UIViewContentModeScaleToFill;
    UILabel *nsa = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 30, 10)];
    nsa.text = @"扫码";
    nsa.font = [UIFont systemFontOfSize:9];
    nsa.adjustsFontSizeToFitWidth = YES;
    nsa.numberOfLines = 1;
    nsa.minimumScaleFactor = 6;
    nsa.textColor = GS_Whitle;
    nsa.textAlignment = NSTextAlignmentCenter;
    
    [v1 addSubview:imgv];
    [v1 addSubview:nsa];
    
    imgv.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(barcodeTapped)];
    tapped.numberOfTapsRequired = 1;
//    tapped.delegate = self;
    [imgv addGestureRecognizer:tapped];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:v1];
    
    
    self.navigationItem.rightBarButtonItem = rightBtn;
}

#pragma MARK:lunbo
/**
123
 
 */
- (void)setLunboDataSource{
    NSMutableArray<UIImage *> *array = [NSMutableArray array];
    
    for (int i = 1; i<6; i++) {
        UIImage *im = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        
        [array addObject:im];
    }
    
    self.lunBoView.imagesArray = [array copy];
    

}
#pragma MARK:ADDMage
- (void)addMainPge{
    self.pageController.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    if (!self.lunBoView) {
        NSLog(@"can not alloc lunboView");
    }
    self.pageController.tableView.tableHeaderView = self.lunBoView;
//    self.pageController.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//    self.pageController.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    
    MS_RefreshGifHeader *gh = [MS_RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    gh.stateLabel.hidden = YES;
    gh.lastUpdatedTimeLabel.hidden = YES;
     self.pageController.tableView.mj_header = gh;
    
    [self.view addSubview:self.pageController.tableView];
}

#pragma  MARK:Getter Setter

- (MainPageTableViewController *)pageController
{
    if (_pageController == nil) {
        _pageController = [[MainPageTableViewController alloc] init];
    }
    return _pageController;
}


- (MSAutoScrollView *)lunBoView
{
    if (_lunBoView) {
        return _lunBoView;
    }
    
    MSAutoScrollView *as = [[MSAutoScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width/2)];
    as.delegate = self;
    
    return _lunBoView = as;
    
}
- (SearchTextFiled *)searchTextFiled
{
    if (_searchTextFiled) {
        return _searchTextFiled;
    }
    
    SearchTextFiled *sc = [[SearchTextFiled alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    sc.inputAccessoryView = self.voiceView;
    sc.borderStyle = UITextBorderStyleRoundedRect;
    sc.returnKeyType = UIReturnKeySearch;
    
    sc.delegate = self;
    sc.searchDelegate = self;
    sc.placeholder = NSLocalizedString(@"placeholder", @"text默认文本");
    sc.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    return _searchTextFiled = sc;
}

- (VoiceSearchIconView *)voiceView
{
    if (_voiceView) {
        return _voiceView;
    }
    VoiceSearchIconView *vc = [[VoiceSearchIconView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    vc.delegate = self;
    return _voiceView = vc;
}




#pragma MARK:Delegate & sel
- (void)searchViewRightImageViewTapped
{
    [self showVoiceView];
}

- (void)btnSpeakerTapped
{
    [self showVoiceView];
}

- (void)barcodeTapped
{
    
    NSLog(@"tap");
    ScanViewController *scan = [[ScanViewController alloc]init];
    scan.showQRCodeInfo = YES;
    
    [scan successfulGetQRCodeInfo:^(NSString *str){
      
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Info" message:str preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         
        [alertCtrl dismissViewControllerAnimated:NO completion:nil];
                                                         [self backNow];
                                                     }];
        
        [alertCtrl addAction:cancel];
        
        [self.parentViewController presentViewController:alertCtrl animated:NO completion:nil];
        
        NSLog(@"%@",str);
    }];

    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:scan animated:NO];

    self.hidesBottomBarWhenPushed=NO;
}

- (void)backNow{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)showVoiceView
{
    
}

- (void)loadNewData{
    NSLog(@"fresh");
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.pageController.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.pageController.tableView.mj_header endRefreshing];
        
    });

}




#pragma MARK:UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isKindOfClass:[SearchTextFiled class]]) {
        
        
    }

    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@", self.searchTextFiled.text);
    self.searchTextFiled.text = @"";
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isKindOfClass:[SearchTextFiled class]]) {
       
        
            [self.searchTextFiled resignFirstResponder];
        
    }
    
//    [self.view  endEditing:YES];
    
    return YES;
}

#pragma MARK:点击屏幕隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.searchTextFiled resignFirstResponder];
   


}


- (void)cycleScrollView:(MSAutoScrollView *)cycleScrollView didSelectImageView:(NSInteger)index
{
    
}



- (void)demo{
    
//    //常用
//    dispatch_sync(<#dispatch_queue_t queue#>, <#^(void)block#>)//同步线程
//    
//    dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>)//异步线程
//    
//    //其他的，比如延迟执行的线程，只执行一次的线程，等等
//    
    
    
    
    
    
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
        //异步执行的事情  a
        
        
        dispatch_async(dispatch_get_main_queue(), ^{ // 2
           
            
            //异步事情 a 做完后通知主线程更新ui
            [self mainQueueUpdateUI];
        });

        
    });
    
    
}

- (void)mainQueueUpdateUI{
    
}

@end


//    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.0f, 0.0f)];
//    scaleAnimation.duration = 0;
//    [self.cancelButton.layer pop_addAnimation:scaleAnimation forKey:@"101"];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.4* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        POPBasicAnimation *scaleAnimation1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//        scaleAnimation1.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//        scaleAnimation1.duration = 0;
//        [self.bacodeView.layer pop_addAnimation:scaleAnimation1 forKey:@"102"];
//    });


//- (void)hidenBarcodeView
//{
//    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.0f, 0.0f)];
//    scaleAnimation.duration = 0.4;
//    [self.bacodeView.layer pop_addAnimation:scaleAnimation forKey:@"103"];
//
//}

