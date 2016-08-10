//
//  ShopCarTableViewCell.h
//  GoodShop
//
//  Created by mike on 6/29/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarItem.h"
@class ShopCarTableViewCell;

@protocol ShopCarCellDelegate <NSObject>

- (void)doClickSelect:(ShopCarTableViewCell *)cell totalPrice:(int)tp;
- (void)shopCarCell:(ShopCarTableViewCell *)cell withNum:(int)productNum price:(float)p productID:(NSString *)idcode;

@end

@interface ShopCarTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ShopCarCellDelegate> delegate;

- (void)configCellWithItem:(ShopCarItem *)item;

@property (nonatomic, assign) BOOL isSelected;

@end
