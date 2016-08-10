//
//  SearchTextFiled.h
//  GoodShop
//
//  Created by mike on 5/16/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBarDelegate.h"

@interface SearchTextFiled : UITextField

@property (nonatomic, weak) id<SearchBarDelegate> searchDelegate;

@end
