//
//  DetailCollectionReusableView.m
//  GoodShop
//
//  Created by mike on 6/16/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "DetailCollectionReusableView.h"

#define CollectionHeaderFont [UIFont systemFontOfSize:13]
@interface DetailCollectionReusableView()

@property (nonatomic, strong)UILabel *textLabel;

@end

@implementation DetailCollectionReusableView

- (void)setHeaderTitle:(NSString *)headerTitle {
    
    _headerTitle = headerTitle;
    
    // 设置背景
    UIImage *backgroundImage = [UIImage imageNamed:@"bg_category_header"];
    self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    // 添加文字标签
    self.textLabel.text = headerTitle;
    [_textLabel sizeToFit];
    // 添加图片
    [self addRankingImage];
}

- (UILabel *)textLabel {
    
    if (_textLabel == nil) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.font = CollectionHeaderFont;
        //textLabel.textColor = [UIColor grayColor];
        
        [self addSubview:textLabel];
        _textLabel = textLabel;
    }
     return _textLabel;
}

- (void)addRankingImage {
    
    UIImageView *rankingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_ranking"]];
    [rankingImage sizeToFit];
    _rankingImage = rankingImage;
    
    [self addSubview:rankingImage];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.x = 20;
    _textLabel.y = 5;
    
    _rankingImage.x = self.width - _rankingImage.width - 10;
    _rankingImage.y = _textLabel.y;
}
@end
