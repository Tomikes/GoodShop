//
//  ShopCarViewController.m
//  GoodShop
//
//  Created by mike on 5/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarTableViewDemo.h"
#import <Masonry.h>
@interface ShopCarViewController ()

@property (nonatomic, strong) ShopCarTableViewDemo *sct;

@end

@implementation ShopCarViewController
@synthesize sct = _sct;

- (void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sct.tableView];
    __weak typeof(self) weakSelf = self;
    [self.sct.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view.mas_top);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(-49);
    }];
      self.title = @"购物车";
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"结算" style:UIBarButtonItemStylePlain target:self action:@selector(pushToCheck)];
    
    
    self.navigationItem.rightBarButtonItem = rightBtn;

}

- (ShopCarTableViewDemo *)sct
{
    if (!_sct) {
        _sct = [[ShopCarTableViewDemo alloc] init];
    }
    return _sct;
}

- (void)pushToCheck{
    NSLog(@"as");
}

@end
