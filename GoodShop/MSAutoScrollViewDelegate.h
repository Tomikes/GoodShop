//
//  MSAutoScrollViewDelegate.h
//  GoodShop
//
//  Created by mike on 5/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MSAutoScrollView;
@protocol MSAutoScrollViewDelegate <NSObject>
- (void)cycleScrollView:(MSAutoScrollView *)cycleScrollView didSelectImageView:(NSInteger)index;
@end
