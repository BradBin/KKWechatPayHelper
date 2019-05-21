//
//  KKAppDelegate.h
//  KKWechatPayHelper
//
//  Created by BradBin on 05/19/2019.
//  Copyright (c) 2019 BradBin. All rights reserved.
//

@import UIKit;

@interface KKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end
//同一订单支付两次的问题，商户保证支付平台的情况下去重
