//
//  KKViewController.h
//  KKWechatPayHelper
//
//  Created by BradBin on 05/19/2019.
//  Copyright (c) 2019 BradBin. All rights reserved.
//

@import UIKit;

@interface KKViewController : UIViewController

@end




@interface KKPayItem : NSObject

@property (nonatomic,copy) NSString *appid;
@property (nonatomic,copy) NSString *noncestr;
@property (nonatomic,copy) NSString *package;
@property (nonatomic,copy) NSString *partnerid;
@property (nonatomic,copy) NSString *prepayid;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,assign) NSTimeInterval timestamp;

@end
