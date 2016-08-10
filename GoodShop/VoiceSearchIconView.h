//
//  VoiceSearchIconView.h
//  GoodShop
//
//  Created by mike on 5/13/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceSearchIconDelegate.h"

@interface VoiceSearchIconView : UIView
@property (nonatomic, strong) UIButton *btnSpeaker;
@property (nonatomic, weak) id<VoiceSearchIconDelegate> delegate;

@end
