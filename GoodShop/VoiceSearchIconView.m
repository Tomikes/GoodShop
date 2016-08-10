//
//  VoiceSearchIconView.m
//  GoodShop
//
//  Created by mike on 5/13/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "VoiceSearchIconView.h"

@implementation VoiceSearchIconView
@synthesize btnSpeaker = _btnSpeaker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = GS_Whitle;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen width], 0.5)];
        line.backgroundColor = [UIColor colorWithHex:0xdcdcdc];
        [self addSubview:line];
        [self addSubview:self.btnSpeaker];
    }
    return self;
}

- (void)dealloc
{
    _delegate = nil;
}

- (UIButton *)btnSpeaker
{
    if (_btnSpeaker) {
        return _btnSpeaker;
    }
    
    _btnSpeaker = [[UIButton alloc] init];
    _btnSpeaker.center = self.center;
    _btnSpeaker.bounds = CGRectMake(0, 2, 23, 36);
    [_btnSpeaker setBackgroundImage:[UIImage imageNamed:@"button-Microphone.png"] forState:UIControlStateNormal];
    [_btnSpeaker addTarget:self action:@selector(btnSpeakerTapped) forControlEvents:UIControlEventTouchUpInside];
    return _btnSpeaker;
    
}

- (void)btnSpeakerTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnSpeakerTapped)]) {
        [self.delegate btnSpeakerTapped];
    }
}

@end
