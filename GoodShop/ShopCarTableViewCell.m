//
//  ShopCarTableViewCell.m
//  GoodShop
//
//  Created by mike on 6/29/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "ShopCarTableViewCell.h"
#import "NumblerTextFiled.h"
#import <Masonry.h>

@interface ShopCarTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) NumblerTextFiled *numText;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *keyWord;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UIButton *checkButton;

//商品数量
@property (nonatomic, assign) int count;

@property (nonatomic, assign) float price;

@end

@implementation ShopCarTableViewCell
@synthesize numText = _numText;
@synthesize priceLabel = _priceLabel;
@synthesize keyWord = _keyWord;
@synthesize detail = _detail;
@synthesize productImageView = _productImageView;
@synthesize checkButton = _checkButton;
@synthesize price = _price;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.isSelected = YES;
        UIView *backView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView = backView;
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        //取消边框线
        [self setBackgroundView:[[UIView alloc] init]];          //取消边框线
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.checkButton];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.numText];
        [self.contentView addSubview:self.keyWord];
        [self.contentView addSubview:self.detail];
        [self.contentView addSubview:self.productImageView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    
    [self.checkButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.checkButton.mas_right).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.keyWord mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-8);
        make.top.mas_equalTo(weakSelf.contentView.mas_top);
        make.left.mas_equalTo(weakSelf.productImageView.mas_right).with.offset(8);
        make.height.mas_equalTo(50);
    }];
    
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(weakSelf.productImageView.mas_right).with.offset(8);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(50);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-8);
        make.height.mas_equalTo(12);
    }];
    
    [self.numText mas_updateConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-8);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(weakSelf.keyWord.mas_left);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).with.offset(-8);
        make.right.mas_equalTo(weakSelf.numText.mas_left);
        make.height.mas_equalTo(24);
    }];
    
}


- (void)configCellWithItem:(ShopCarItem *)item
{
    self.productImageView.image = item.productImage;
    
    if (!item.price) {
        self.priceLabel.text = [NSString stringWithFormat:@"¥ 0.00"];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[item.price floatValue]];
    }

    self.keyWord.attributedText = [self adjustDetailText:item.keyWord];
    self.detail.text = item.detail;
}
- (UIImageView *)productImageView
{
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.contentMode = UIViewContentModeScaleAspectFit;
        _productImageView.backgroundColor = [UIColor whiteColor];
    }
    return _productImageView;
}

- (UILabel *)keyWord{
    if (!_keyWord) {
        _keyWord = [[UILabel alloc] init];
        _keyWord.font = [UIFont systemFontOfSize:12];
        _keyWord.adjustsFontSizeToFitWidth = YES;
        _keyWord.numberOfLines = 2;
        _keyWord.minimumScaleFactor = 9;
        _keyWord.lineBreakMode = NSLineBreakByWordWrapping;
        _keyWord.textColor = [UIColor blackColor];
        _keyWord.textAlignment = NSTextAlignmentLeft;
    }
    return _keyWord;
}

- (UILabel *)detail
{
    if (!_detail) {
        _detail = [[UILabel alloc] init];
        _detail.font = [UIFont systemFontOfSize:12];
        _detail.numberOfLines = 1;
        _detail.minimumScaleFactor = 9;
        _detail.textColor = [UIColor grayColor];
        _detail.textAlignment = NSTextAlignmentLeft;
    }
    return _detail;
}

//调整detail的样式
- (NSMutableAttributedString *)adjustDetailText:(NSString *)str
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    return attributedString;
//    keyWord.attributedText = attributedString;
//    [keyWord sizeToFit];

}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor redColor];
            }
    return _priceLabel;
}


- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkButton addTarget:self action:@selector(clickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.checkButton setImage:[UIImage imageNamed:@"ra_pressed"] forState:UIControlStateNormal];
        
    }
    return _checkButton;
}
- (void)clickSelectBtn
{
    if (self.isSelected) {
        self.isSelected = NO;
        [self.checkButton setImage:[UIImage imageNamed:@"ra_normal"] forState:UIControlStateNormal];

    }else{
        self.isSelected = YES;
        [self.checkButton setImage:[UIImage imageNamed:@"ra_pressed"] forState:UIControlStateNormal];
        [self triggerDelegate];
    }

}
- (NumblerTextFiled *)numText
{
    if (!_numText) {
        _numText = [[NumblerTextFiled alloc] initWithFrame:CGRectMake(self.contentView.x-88, self.contentView.bottom-28, 100, 20)];
        
        _numText.layer.cornerRadius = 5;
        
        _numText.delegate = self;
        
        [_numText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_numText addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return _numText;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        if ([change[@"new"] intValue] >= 1) {
            [self.checkButton setImage:[UIImage imageNamed:@"ra_pressed"] forState:UIControlStateNormal];
            self.isSelected = YES;
        }else{
            self.isSelected = NO;
            [self.checkButton setImage:[UIImage imageNamed:@"ra_normal"] forState:UIControlStateNormal];
        }
    }
}

- (void)textFieldDidChange:(UITextField *)sender
{
    if ([sender isKindOfClass:[UITextField class]]) {
        if (sender.text.length > 2)  // MAXLENGTH为最大字数
        {
            sender.text = [sender.text substringToIndex: 2];
        }
        
        if ([sender.text intValue] >= 1) {
            self.isSelected = YES;
            [self.checkButton setImage:[UIImage imageNamed:@"ra_pressed"] forState:UIControlStateNormal];
        }else{
            self.isSelected = NO;
            [self.checkButton setImage:[UIImage imageNamed:@"ra_normal"] forState:UIControlStateNormal];
        }

    }
    
         [self triggerDelegate];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
       return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)triggerDelegate
{
    if (self.isSelected) {
        int ttt;
        ttt = self.price*([self.numText.text intValue]);
        if (self.delegate && [self.delegate respondsToSelector:@selector(doClickSelect:totalPrice:)]) {
            [self.delegate doClickSelect:self totalPrice:ttt];
        }

    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.contentView endEditing:YES];
    
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"text"];
}


@end
