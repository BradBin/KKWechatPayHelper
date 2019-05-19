//
//  KKWechatPayItem.h
//  KKWechatPayHelper
//
//  Created by Macbook Pro 15.4  on 2019/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKWechatPayItem : NSObject
/** 请求类型 */
@property (nonatomic, assign) int type;
/** 由用户微信号和AppID组成的唯一标识，发送请求时第三方程序必须填写，用于校验微信用户是否换号登录*/
@property (nonatomic, retain) NSString* openID;

@end





/**
 第三方向微信终端发起支付的消息结构体
 */
@interface KKWechatPayReq : KKWechatPayItem

/** 商家向财付通申请的商家id */
@property (nonatomic, retain) NSString *partnerId;
/** 预支付订单 */
@property (nonatomic, retain) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic, retain) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timeStamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, retain) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, retain) NSString *sign;

@end






NS_ASSUME_NONNULL_END
