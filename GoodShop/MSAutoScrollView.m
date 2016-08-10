//
//  MSAutoScrollView.m
//  MikeShop
//
//  Created by mike on 4/28/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "MSAutoScrollView.h"
#import "NSTimer+Addition.h"
#import "UIImage+Resize.h"


#define c_width (self.bounds.size.width) //两张图片之前有10点的间隔
#define c_height (self.bounds.size.height)

@interface MSAutoScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, strong) NSMutableArray<UIImage *> *currentImageViewArray;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic , weak) UIScrollView *scrollView;
@end

@implementation MSAutoScrollView

@synthesize timer = _timer;
@synthesize scrollView = _scrollView;
@synthesize currentIndex = _currentIndex;
@synthesize pageControl = _pageControl;
@synthesize currentImageViewArray = _currentImageViewArray;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
       
        //初始化数据，当前图片默认位置是0
        self.currentIndex = 0;
        [self getDisplayImagesWithCurpage:self.currentIndex];
        
        self.currentImageViewArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        [UIColor whiteColor];
    }
    return self;
}


#pragma mark -accessor

- (void)setImagesArray:(NSMutableArray *)imagesArray
{
    _imagesArray = imagesArray;
    //设置分页控件的总页数
    self.pageControl.numberOfPages = imagesArray.count;
    //刷新图片
    [self reloadData];

    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    //判断图片长度是否大于1，如果一张图片不开启定时器
    if ([imagesArray count] > 1) {
        _timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerScrollImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:UITrackingRunLoopMode beforeDate:[NSDate date]];
    }
}

- (UIPageControl *)pageControl
{
    if (_pageControl) {
        return _pageControl;
    }
    
    UIPageControl *pg = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height-30, self.width, 30)];
    pg.pageIndicatorTintColor        = [UIColor lightGrayColor];
    pg.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl = pg;
    return _pageControl;
}


- (UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, c_width, c_height)];
    sc.contentMode = UIViewContentModeCenter;  
    sc.contentSize = CGSizeMake(c_width*3, 0);
    sc.contentOffset = CGPointMake(c_width, 0);
    sc.scrollsToTop = NO;
    sc.pagingEnabled = YES;
    
    sc.showsVerticalScrollIndicator = NO;
    sc.showsHorizontalScrollIndicator = NO;
    sc.delegate = self;
    
    _scrollView = sc;
    
    
    return  _scrollView;

    
}
#pragma MARK 刷新图片
- (void)reloadData
{
    //设置页数
    self.pageControl.currentPage = self.currentIndex;
    //根据当前页取出图片
    [self getDisplayImagesWithCurpage:self.currentIndex];
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [self.scrollView subviews];
    if ([subViews count] > 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    if (self.currentImageViewArray.count != 0) {
        //创建imageView
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(c_width*i, 0, self.bounds.size.width, c_height)];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.scrollView addSubview:imageView];
            
            UIImage *ims = self.currentImageViewArray[i];
            imageView.image = [ims resizedImage:CGSizeMake(self.width, self.height) interpolationQuality:kCGInterpolationHigh];
            //tap手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
            [imageView addGestureRecognizer:tap];
            
            UILongPressGestureRecognizer *longTapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapGestureAction:)];
            [imageView addGestureRecognizer:longTapGesture];
        }
        
    }else{
        //@throw <#expression#>
    }
}

- (void)getDisplayImagesWithCurpage:(NSInteger)page
{
    //取出开头和末尾图片在图片数组里的下标
    NSInteger front = page - 1;
    NSInteger last = page + 1;
    
    if (self.imagesArray.count != 0) {
        //如果当前图片下标是0，则开头图片设置为图片数组的最后一个元素
        if (page == 0) {
            front = [self.imagesArray count]-1;
        }
        
        //如果当前图片下标是图片数组最后一个元素，则设置末尾图片为图片数组的第一个元素
        if (page == [self.imagesArray count]-1) {
            last = 0;
        }
        
        //如果当前图片数组不为空，则移除所有元素
        if ([self.currentImageViewArray count] > 0) {
            [self.currentImageViewArray removeAllObjects];
        }
        
        //当前图片数组添加图片
        [self.currentImageViewArray addObject:[self.imagesArray objectAtIndex:front]];
        [self.currentImageViewArray addObject:[self.imagesArray objectAtIndex:page]];
        [self.currentImageViewArray addObject:[self.imagesArray objectAtIndex:last]];
        
    }else{
        //throw error
    }
    
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //right
    //如果scrollView当前偏移位置x大于等于两倍scrollView宽度
    if (scrollView.contentOffset.x >= c_width*2) {
        //当前图片位置+1
        self.currentIndex++;
        //如果当前图片位置超过数组边界，则设置为0
        if (self.currentIndex == [self.imagesArray count]) {
            self.currentIndex = 0;
        }
        //刷新图片
        [self reloadData];
        //设置scrollView偏移位置 center
        [scrollView setContentOffset:CGPointMake(c_width, 0)];
    }
    //left
    //如果scrollView当前偏移位置x小于等于0
    else if (scrollView.contentOffset.x <= 0) {
        //当前图片位置-1
        self.currentIndex--;
        //如果当前图片位置小于数组边界，则设置为数组最后一张图片下标
        if (self.currentIndex == -1) {
            self.currentIndex = [self.imagesArray count]-1;
        }
        //刷新图片
        [self reloadData];
        //设置scrollView偏移位置 center
        [scrollView setContentOffset:CGPointMake(c_width, 0)];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer pauseTimer];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.timer resumeTimerAfterTimeInterval:5];
}

#pragma MARK 保证无跳动衔接关键点
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //设置scrollView偏移位置
    [scrollView setContentOffset:CGPointMake(c_width, 0) animated:YES];
    
}

- (void)longTapGestureAction:(UILongPressGestureRecognizer *)tapGesture
{
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        //        NSLog(@"UIGestureRecognizerStateBegan");
        [self.timer pauseTimer];
        
    }
    if (tapGesture.state == UIGestureRecognizerStateEnded) {
        [self.timer resumeTimerAfterTimeInterval:5];
       
        //        NSLog(@"UIGestureRecognizerStateEnded");
    }
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    //设置代理
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectImageView:)]) {
        [self.delegate cycleScrollView:self didSelectImageView:self.currentIndex];
    }
}

- (void)timerScrollImage
{
    //刷新图片
    [self reloadData];
    
    //设置scrollView偏移位置
    [self.scrollView setContentOffset:CGPointMake(c_width*2, 0) animated:YES];}

- (void)dealloc
{
    //代理指向nil，关闭定时器
    self.scrollView.delegate = nil;
    [self.timer invalidate];
}
@end
