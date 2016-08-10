//
//  MainPageTableViewController.m
//  GoodShop
//
//  Created by mike on 6/15/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "MainPageTableViewController.h"

static NSString * const mainPageTableCellId = @"cell";

@interface MainPageTableViewController ()

//dedasource

@end

@implementation MainPageTableViewController

#pragma mark - 初始化
- (instancetype)init {
    
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 去除分割线
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 取消滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.multipleTouchEnabled = NO;
    
    //注册cell， 本表所有的cell都是代码定义
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mainPageTableCellId];
    
   
    //添加其它类型的cell
    //    [self.mainTableView registerClass:[GGTableViewCell class] forCellReuseIdentifier:GGTableCellId];
    //填充数据
    [self loadData];
   
}

#pragma mark - loadData
- (void)loadData{
    //[self.tableView reloadData];
}

#pragma mark - Table view data source

#pragma MARK:UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainPageTableCellId forIndexPath:indexPath];
    //选中时背景透明
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    //取消边框线
    [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@", indexPath);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
