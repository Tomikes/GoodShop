//
//  UserViewController.m
//  GoodShop
//
//  Created by mike on 5/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "UserViewController.h"
#import <Masonry.h>
#import "HFStretchableTableHeaderView.h"

#define StretchHeaderHeight 200

@interface UserViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)HFStretchableTableHeaderView *stretchHeaderView;

@end

static NSString *const cellIDS = @"cell123";
@implementation UserViewController

- (void)loadView
{
    [super loadView];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    self.headView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"backImage" ofType:@"jpg"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIDS];
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    }
    return _tableView;
}

- (UIImageView *)headView{
    
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _headView.backgroundColor = [UIColor blackColor];
        _headView.contentMode = UIViewContentModeScaleAspectFill;
        _headView.clipsToBounds = YES;
        _headView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
       
    }
    return _headView;
}

#pragma mark - 设置分割线顶头
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIDS forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}



@end
