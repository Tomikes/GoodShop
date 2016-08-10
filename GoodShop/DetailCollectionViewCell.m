//
//  DetailCollectionViewCell.m
//  GoodShop
//
//  Created by mike on 6/16/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "UIImageView+WebCache.h"

#define QWCategoryCellTextSize [UIFont systemFontOfSize:11]

@interface DetailCollectionViewCell()



@end

@implementation DetailCollectionViewCell
@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;

- (instancetype)initWithFrame:(CGRect)frame{
   self =  [super initWithFrame:frame];
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.textLabel];
    return self;
}
#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (_imageView == nil) {
        // 注意：这里不需要设置frame，子控件的frame都在layoutSubviews中设置
        UIImageView *tempImageView = [[UIImageView alloc] init];
        tempImageView.image = [UIImage imageNamed:@"jdm_photo_placeholer"];
      
        
        _imageView = tempImageView;
        
        // 注意：一定要加载到contentView上，如果加载到view上则有可能被遮住
        
    }
    
    return _imageView;
}

- (UILabel *)textLabel {
    if (_textLabel == nil) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor whiteColor];
        textLabel.font = QWCategoryCellTextSize;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        textLabel.layer.borderWidth = 1;
        _textLabel = textLabel;
       
    }
    
    return _textLabel;
}


#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    // 图片
    self.imageView.frame = CGRectMake(0, 0, self.width, self.height * 0.7);
    // 文字
    self.textLabel.frame = CGRectMake(0, self.height * 0.7, self.width, self.height * 0.3);
    
}

@end
