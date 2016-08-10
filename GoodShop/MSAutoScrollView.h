//
//  MSAutoScrollView.h
//  MikeShop
//
//  Created by mike on 4/28/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAutoScrollViewDelegate.h"
@interface MSAutoScrollView : UIView
/**
  RequsetImageArray
 */
@property (nonatomic, strong) NSMutableArray<UIImage *> *imagesArray;

@property (nonatomic, weak) id<MSAutoScrollViewDelegate> delegate;



@end
