//
//  CategoryViewController.m
//  GoodShop
//
//  Created by mike on 6/15/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "CategoryViewController.h"
#import "LeftTableViewController.h"
#import "RightCollectionViewController.h"
#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0
@interface CategoryViewController ()

@property (nonatomic, strong) LeftTableViewController *leftMenu;
@property (nonatomic, strong) RightCollectionViewController *rightMenu;


@end

@implementation CategoryViewController

@synthesize leftMenu = _leftMenu;
@synthesize rightMenu = _rightMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"CategoryTitle",@"CategoryTitle");
    
   self.view.backgroundColor = GS_Whitle;
    
    
    self.leftMenu.tableView.frame = CGRectMake(0, 0, 100*ratio, kScreenHeight);
    
    [self.view addSubview:self.leftMenu.tableView];
    [self addCategoryDetailCollectionView];
    
    
}


- (LeftTableViewController *)leftMenu
{
    if (_leftMenu == nil) {
        _leftMenu = [[LeftTableViewController alloc] init];
    }
    return _leftMenu;
}

- (RightCollectionViewController *)rightMenu
{
    if (_rightMenu == nil) {
        _rightMenu = [[RightCollectionViewController alloc] init];
    }
    return _rightMenu;
}

#pragma mark - 添加详细分类列表
- (void)addCategoryDetailCollectionView {
    // 计算详细分类列表视图尺寸

    
    self.rightMenu.view.frame = CGRectMake(100*ratio+2, 0, self.view.width - 100*ratio-4, kScreenHeight);
    
    [self.view addSubview:self.rightMenu.view];

    
    
}

@end
