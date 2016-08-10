//
//  RightCollectionViewController.m
//  GoodShop
//
//  Created by mike on 6/15/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "RightCollectionViewController.h"
#import "DetailCollectionViewCell.h"
#import "DetailCollectionReusableView.h"
#import "CategoryViewController.h"

static NSString * const collReuseIdentifier = @"Cell";
static NSString * const reuseViewCellIdentifiler = @"viewCell";
#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0
@interface RightCollectionViewController ()

@end

@implementation RightCollectionViewController

- (instancetype)init{
    return [super initWithCollectionViewLayout:[self flowLayout]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    

    self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 48, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);

    // 注册cell
    [self.collectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:collReuseIdentifier];
    
    [self.collectionView registerClass:[DetailCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseViewCellIdentifiler];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // Do any additional setup after loading the view.
}


- (UICollectionViewFlowLayout *)flowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell的尺寸
    flowLayout.itemSize = CGSizeMake((kScreenWidth - 100*ratio-10-2-4) / 3, (kScreenWidth - 100*ratio-10-2-4)*1.3 / 3);
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 30);
    
    // 清空间距
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 10;
    
    return flowLayout;

}

#pragma mark - <UICollectionViewDataSource>
#pragma mark 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}

#pragma mark 每组有多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

#pragma mark cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collReuseIdentifier forIndexPath:indexPath];
    // 取出模型数据
    cell.textLabel.text = [NSString stringWithFormat:@"2016:%ld", (long)indexPath.row];
    
    
    return cell;
}

#pragma mark 附加控件长什么样
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        DetailCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseViewCellIdentifiler forIndexPath:indexPath];
        
        reusableView = headerView;
    }
    
    reusableView.headerTitle = [NSString stringWithFormat:@"时尚元素+%ld",(long)indexPath.row];
       
    return reusableView;
}

#pragma mark - <UICollectionViewDelegate>
#pragma mark 选中cell时做什么
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
       // 跳转
    
    if ([self.view.superview.nextResponder isKindOfClass:[CategoryViewController class]]) {
        CategoryViewController *categoryVC = (CategoryViewController *)self.view.superview.nextResponder;
        categoryVC.hidesBottomBarWhenPushed = YES;
        categoryVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [categoryVC presentViewController:[UIViewController new] animated:YES completion:nil];
        categoryVC.hidesBottomBarWhenPushed = NO;
    }
    
    
    
}


@end
