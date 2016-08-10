//
//  SearchTextFiled.m
//  GoodShop
//
//  Created by mike on 5/16/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "SearchTextFiled.h"
#import "UIImage+Color.h"

@interface SearchTextFiled ()

@property (nonatomic, strong) UIColor *colorButtonClearHighlighted;
@property (nonatomic, strong) UIColor *colorButtonClearNormal;

@property (nonatomic, strong) UIImage *imageButtonClearHighlighted;
@property (nonatomic, strong) UIImage *imageButtonClearNormal;

@property (nonatomic, weak) UIImageView *leftImageView;
@property (nonatomic, weak) UIImageView *rightImageView;

@end

@implementation SearchTextFiled
@synthesize colorButtonClearHighlighted= _colorButtonClearHighlighted;
@synthesize colorButtonClearNormal = _colorButtonClearNormal;
@synthesize imageButtonClearHighlighted = _imageButtonClearHighlighted;
@synthesize imageButtonClearNormal = _imageButtonClearNormal;
@synthesize leftImageView = _leftImageView;
@synthesize rightImageView = _rightImageView;

#pragma MARK: Life

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftView = self.leftImageView;
        self.rightView = self.rightImageView;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeUnlessEditing;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        self.colorButtonClearNormal = GS_Whitle;
        self.colorButtonClearHighlighted = GS_Red;
        

    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    [self tintButtonClear];
}


-(CGRect) leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 5;
    return iconRect;
}

- (CGRect) rightViewRectForBounds:(CGRect)bounds {
    
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= 5;
    return textRect;
}

#pragma MARK: Setter & Getter
-(void) setColorButtonClearHighlighted:(UIColor *)colorButtonClearHighlighted
{
    _colorButtonClearHighlighted = colorButtonClearHighlighted;
}

-(void) setColorButtonClearNormal:(UIColor *)colorButtonClearNormal
{
    _colorButtonClearNormal = colorButtonClearNormal;
}

- (UIImageView *)leftImageView
{
    if (_leftImageView) {
        return _leftImageView;
    }
    CGFloat height = self.frame.size.height;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(height / 4, height / 4, height / 2, height / 2)];
    img.image = [UIImage imageNamed:@"search"];
    
     _leftImageView = img;
    return _leftImageView;
    
}

- (UIImageView *)rightImageView
{
    if (_rightImageView) {
        return _rightImageView;
    }
    
    CGFloat height = self.frame.size.height;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(height / 4, height / 4, height / 2, height / 2)];
    img.image = [UIImage imageNamed:@"voice"];
    img.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voiceImageTag:)];
    [img addGestureRecognizer:tap];
    
    _rightImageView = img;
    return _rightImageView;
    
}

- (void)voiceImageTag:(id)sender
{
    if (self.searchDelegate && [self.searchDelegate respondsToSelector:@selector(searchViewRightImageViewTapped)]) {
        [self.searchDelegate searchViewRightImageViewTapped];
    }
}


#pragma MARK: cancelButton
- (void)tintButtonClear
{
    UIButton *buttonClear = [self buttonClear];
    
    if(self.colorButtonClearNormal && self.colorButtonClearHighlighted && buttonClear)
    {
        if(!self.imageButtonClearHighlighted)
        {
            UIImage *imageHighlighted = [buttonClear imageForState:UIControlStateHighlighted];
            self.imageButtonClearHighlighted = [UIImage imageWithImage:imageHighlighted
                                                                  tintColor:self.colorButtonClearHighlighted];
        }
        if(!self.imageButtonClearNormal)
        {
            UIImage *imageNormal = [buttonClear imageForState:UIControlStateNormal];
            self.imageButtonClearNormal = [UIImage imageWithImage:imageNormal
                                                             tintColor:self.colorButtonClearNormal];
        }
        
        if(self.imageButtonClearHighlighted && self.imageButtonClearNormal)
        {
            [buttonClear setImage:self.imageButtonClearHighlighted forState:UIControlStateHighlighted];
            [buttonClear setImage:self.imageButtonClearNormal forState:UIControlStateNormal];
        }
    }
}

-(UIButton *) buttonClear
{
    for(UIView *v in self.subviews)
    {
        if([v isKindOfClass:[UIButton class]])
        {
            UIButton *buttonClear = (UIButton *)v;
            
            return buttonClear;
        }
    }
    return nil;
}


@end
