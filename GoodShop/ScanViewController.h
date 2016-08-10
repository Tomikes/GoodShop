//
//  ScanViewController.h
//  GoodShop
//
//  Created by mike on 6/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^successBlock)(NSString *QRCodeInfo);

@interface ScanViewController : UIViewController


@property (nonatomic, strong) successBlock block;

/**
 *是否需要将扫码得到的信息进行回传并展示
 *@param   默认值   Default is NO
 */
@property (nonatomic, assign) BOOL showQRCodeInfo;

/**
 *扫码成功后回传
 */
- (void)successfulGetQRCodeInfo:(successBlock)success;

@end
