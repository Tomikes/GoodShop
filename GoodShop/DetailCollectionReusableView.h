//
//  DetailCollectionReusableView.h
//  GoodShop
//
//  Created by mike on 6/16/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionReusableView : UICollectionReusableView

/**
 *  组的头标题
 */
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, weak)UIImageView *rankingImage;

@end
