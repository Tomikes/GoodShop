//
//  MS_RefreshGifHeader.m
//  MikeShop
//
//  Created by mike on 4/25/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "MS_RefreshGifHeader.h"

@interface MS_RefreshGifHeader()

@property (nonatomic, weak) UIImageView *gifImageView;
@property (nonatomic, weak) UILabel *statusLabel;

@property (nonatomic, strong) NSMutableArray<UIImage *> *commImages;
@property (nonatomic, strong) NSMutableArray<UIImage *> *refreshingimages;


@end


@implementation MS_RefreshGifHeader
@synthesize commImages = _commImages;
@synthesize refreshingimages = _refreshingimages;
@synthesize gifImageView = _gifImageView;
@synthesize statusLabel = _statusLabel;

- (void)prepare
{
    [super prepare];
    self.mj_h = 100;
    

}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // [self gifImageView].frame; 重写frame
    self.gifImageView.frame = CGRectMake(0, 0, self.width, 80);
    self.statusLabel.frame = CGRectMake(0, 60, self.width, 40);
}

- (UILabel *)statusLabel
{
    if (_statusLabel) {
        return _statusLabel;
    }
    
    UILabel *lb = [[UILabel alloc] init];
    lb.textColor = [UIColor grayColor];
    lb.font = [UIFont boldSystemFontOfSize:12];
    lb.textAlignment = NSTextAlignmentCenter;
    
    _statusLabel = lb;
    
    [self addSubview:_statusLabel];
    return _statusLabel;
    
}

- (UIImageView *)gifImageView
{
    if (_gifImageView) {
        return _gifImageView;
    }
    
    UIImageView *gifView = [[UIImageView alloc] init];
    gifView.contentMode = UIViewContentModeCenter;
  
    _gifImageView = gifView;
    
    [self addSubview:_gifImageView];
    
    return _gifImageView;
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    if (state == MJRefreshStateRefreshing) {
        NSArray *images = self.refreshingimages;
        [self.gifImageView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifImageView.image = [images lastObject];
        } else { // 多张图片
            self.gifImageView.animationImages = images;
            self.gifImageView.animationDuration = images.count*0.1;
            [self.gifImageView startAnimating];
        }

    }else{
        [self.gifImageView stopAnimating];
        NSArray<UIImage *> *images = self.commImages;
       
        NSUInteger index =  images.count * self.pullingPercent;
        if (index >= images.count) index = images.count - 1;
        self.gifImageView.image = images[index];
    }
   
    switch (state) {
        case MJRefreshStateIdle:
            self.statusLabel.text = NSLocalizedString(@"Drop-down refresh",nil);
            break;
        case MJRefreshStatePulling:
            
            self.statusLabel.text = NSLocalizedString(@"Release immediately refresh", nil);
            break;
        case MJRefreshStateRefreshing:
            self.statusLabel.text = NSLocalizedString(@"Refreshing", nil);
            break;
        default:
            break;
    }
}



#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
}



- (NSMutableArray<UIImage *> *)commImages
{
    
    if (!_commImages) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSUInteger i = 1; i<=60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
            [array addObject:image];
        }
        
        _commImages = array;

    }
    return _commImages;
}

- (NSMutableArray<UIImage *> *)refreshingimages
{
    if (!_refreshingimages) {
         NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
            [refreshingImages addObject:image];
        }
        _refreshingimages = refreshingImages;
    }
    return _refreshingimages;
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}


@end
