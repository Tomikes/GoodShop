//
//  NumblerTextFiled.m
//  GoodShop
//
//  Created by mike on 6/22/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "NumblerTextFiled.h"
#import "UIImage+Color.h"
#import "UIView+CustomBorder.h"

@interface NumblerTextFiled()

@property (nonatomic, strong) UIColor *colorButtonClearHighlighted;
@property (nonatomic, strong) UIColor *colorButtonClearNormal;

@property (nonatomic, strong) UIImage *imageButtonClearHighlighted;
@property (nonatomic, strong) UIImage *imageButtonClearNormal;

@property (nonatomic, weak) UIImageView *leftImageView;
@property (nonatomic, weak) UIImageView *rightImageView;

@end

@implementation NumblerTextFiled
@synthesize colorButtonClearHighlighted= _colorButtonClearHighlighted;
@synthesize colorButtonClearNormal = _colorButtonClearNormal;
@synthesize imageButtonClearHighlighted = _imageButtonClearHighlighted;
@synthesize imageButtonClearNormal = _imageButtonClearNormal;
@synthesize leftImageView = _leftImageView;
@synthesize rightImageView = _rightImageView;

- (instancetype)init{
   self = [super init];
    if (self) {
        self.leftView = self.leftImageView;
        self.rightView = self.rightImageView;
        
        [self.leftView addRightBorderWithColor:[UIColor blackColor] width:0.5];
        [self.rightView addLeftBorderWithColor:[UIColor blackColor] width:0.5];
        
        self.textAlignment = NSTextAlignmentCenter;
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        
        self.text = @"1";
        self.colorButtonClearNormal = GS_Whitle;
        self.colorButtonClearHighlighted = GS_Red;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftView = self.leftImageView;
        self.rightView = self.rightImageView;
        
        [self.leftView addRightBorderWithColor:[UIColor blackColor] width:0.5];
        [self.rightView addLeftBorderWithColor:[UIColor blackColor] width:0.5];
        
        self.textAlignment = NSTextAlignmentCenter;
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeAlways;
        

        self.text = @"1";
        self.colorButtonClearNormal = GS_Whitle;
        self.colorButtonClearHighlighted = GS_Red;
        self.keyboardType = UIKeyboardTypeNumberPad;
   
        
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
  
}

//-(CGRect) leftViewRectForBounds:(CGRect)bounds {
//    CGRect iconRect = [super leftViewRectForBounds:bounds];
//    iconRect.origin.x += 5;
//    return iconRect;
//}
//
//- (CGRect) rightViewRectForBounds:(CGRect)bounds {
//    
//    CGRect textRect = [super rightViewRectForBounds:bounds];
//    textRect.origin.x -= 5;
//    return textRect;
//}

- (UIImageView *)leftImageView
{
    if (_leftImageView) {
        return _leftImageView;
    }
    CGFloat height = self.frame.size.height;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    img.image = [UIImage imageNamed:@"redus"];
    img.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(redusTouch:)];
    [img addGestureRecognizer:tap];
    
    _leftImageView = img;
    return _leftImageView;
    
}

- (UIImageView *)rightImageView
{
    if (_rightImageView) {
        return _rightImageView;
    }
    
    CGFloat height = self.frame.size.height;
     UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    img.image = [UIImage imageNamed:@"add"];
    img.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTouch:)];
    [img addGestureRecognizer:tap];
    
    _rightImageView = img;
    return _rightImageView;
    
}

//获得购物车项的数量
- (NSNumber *)getCount
{
    return [NSNumber numberWithInt:[self.text intValue]];
}

- (void) setCount:(NSNumber *)count
{
    self.text = [count stringValue];
}

- (void)addTouch:(id)sender
{
    NSNumber *i =[self getCount];
    
    [self setCount:[NSNumber numberWithInt:[i intValue]+1]];
}

- (void)redusTouch:(id)sender
{
    NSNumber *i =[self getCount];
    if ([i intValue] < 1) {
        [self setCount:[NSNumber numberWithInt:0]];
    }else{
        [self setCount:[NSNumber numberWithInt:[i intValue]-1]];}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
  

}

@end
