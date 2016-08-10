//
//  LeftTableViewController.m
//  GoodShop
//
//  Created by mike on 6/15/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "LeftTableViewController.h"
#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0
#define QWCellTextFont [UIFont systemFontOfSize:15*ratio]

static NSString * const categoryTableCellId = @"cell";

@interface LeftTableViewController ()

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation LeftTableViewController



#pragma mark - 初始化
- (instancetype)init {
    
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self loadCategoryData];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 48, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 取消滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.multipleTouchEnabled = NO;
    // 不允许下拉
    self.tableView.bounces = YES;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:categoryTableCellId];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 返回本页面时，重新选中原来的选项
    [self.tableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - 加载一级分类数据
- (void)loadCategoryData {
    
   
}

#pragma mark - <UITableViewDataSource>
#pragma mark 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
#pragma mark 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

#pragma mark cell长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryTableCellId forIndexPath:indexPath];
  
    cell.textLabel.text = [NSString stringWithFormat:@"京东金融"];

    

    // 设置cell背景
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cell_normal_h"]];
    // 设置cell被选中时的背景
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cell_redline"]];
    
    [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.font = QWCellTextFont;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    // 设置cell内容
    return cell;
}
#pragma mark - <UITableViewDelegate>
#pragma mark 取消选中后做什么
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 点击cell会怎么样
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 保存所选cell位置
    _selectedIndexPath = indexPath;
    // 滚到顶端
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    // 字体变红
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor redColor];
    
//    // 取出分类id
//    QWCategory *selectedCategory = self.catelogyList[indexPath.row];
//    if ([_selectedCategory.cid isEqualToString: selectedCategory.cid] == NO) { // 不重复点击
//        
//        _selectedCategory = selectedCategory;
//        // 发送通知,传递参数cid
//        [[NSNotificationCenter defaultCenter] postNotificationName:QWDetailCategoryDataWillLoadNotification object:selectedCategory.cid];
//    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
}

@end
