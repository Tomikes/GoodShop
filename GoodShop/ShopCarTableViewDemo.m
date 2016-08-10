//
//  ShopCarTableViewDemo.m
//  GoodShop
//
//  Created by mike on 6/22/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "ShopCarTableViewDemo.h"
#import "ShopCarTableViewCell.h"
#import "ShopCarItem.h"

static NSString * const mainPageTableCellId = @"shopCell";
@interface ShopCarTableViewDemo ()<ShopCarCellDelegate>
{
    ShopCarItem *item;
}



@end

@implementation ShopCarTableViewDemo

- (instancetype)init {
    
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);

    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 取消滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.multipleTouchEnabled = NO;
    
    //注册cell， 本表所有的cell都是代码定义
    [self.tableView registerClass:[ShopCarTableViewCell class] forCellReuseIdentifier:mainPageTableCellId];
    item = [[ShopCarItem alloc] init];
    item.price = @"99";
    item.productImage = [UIImage imageNamed:@"123.png"];
    item.detail = @"颜色: 白色";
    item.keyWord = @"本表所有 cell 都是 代码定义 本表所有 cell 都是 代码定义";
    
     [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 117;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainPageTableCellId forIndexPath:indexPath];
    //选中时背景透明
    [cell configCellWithItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

- (void)doClickSelect:(ShopCarTableViewCell *)cell totalPrice:(int)tp{
    
}

@end
