//
//  VerticalScrollDelegate.h
//  GoodShop
//
//  Created by mike on 5/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VerticalScrollingView;
@protocol VerticalScrollDelegate <NSObject>

@optional

/** 点击图片*/
- (void)infiniteScrollView:(VerticalScrollingView *)ScrollView didSelectItemAtIndex:(NSInteger)tags;

@end
