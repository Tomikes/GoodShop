//
//  ShopCarItem.h
//  GoodShop
//
//  Created by mike on 6/29/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarItem : NSObject

@property (nonatomic, strong) NSString *itemID;
@property (nonatomic, strong) UIImage *productImage;
@property (nonatomic, strong) NSString *keyWord;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *price;

@end
