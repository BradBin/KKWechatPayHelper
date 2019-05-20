//
//  KKWechatPayItem.h
//  KKWechatPayHelper
//
//  Created by Macbook Pro 15.4  on 2019/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKWechatPayItem : NSObject
/** 请求/响应类型 */
@property (nonatomic,assign) NSInteger type;

@end




#pragma mark -
#pragma mark - 微信支付相关基类
/**
 微信终端SDK所有请求类的基类
 */
@interface KKWechatPayBaseRequest : KKWechatPayItem
/** 由用户微信号和AppID组成的唯一标识，发送请求时第三方程序必须填写，用于校验微信用户是否换号登录*/
@property (nonatomic,  copy) NSString* openID;
@end

/**
 微信终端SDK所有响应类的基类
 */
@interface KKWechatPayBaseResponse : KKWechatPayItem
/** 错误码 */
@property (nonatomic,assign) NSInteger errCode;
/** 错误提示字符串 */
@property (nonatomic,  copy) NSString *errStr;
@end





#pragma mark -
#pragma mark - 微信支付相关

#ifndef BUILD_WITHOUT_PAY
/**
 第三方向微信终端发起支付的消息结构体
 */
@interface KKWechatPayRequest : KKWechatPayBaseRequest
/** 商家向财付通申请的商家id */
@property (nonatomic,  copy) NSString *partnerId;
/** 预支付订单 */
@property (nonatomic,  copy) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic,  copy) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic,assign) NSTimeInterval timeStamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic,  copy) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic,  copy) NSString *sign;
@end

#endif


#ifndef BUILD_WITHOUT_PAY
/**
 微信终端返回给第三方的关于支付结果的结构体
 */
@interface KKWechatPayResponse : KKWechatPayBaseResponse
/** 财付通返回给商家的信息 */
@property (nonatomic,  copy) NSString *returnKey;
@end
#endif




#pragma mark -
#pragma mark - 认证/授权相关

/**
 请求认证的消息结构
 */
@interface KKWechatAuthorRequest : KKWechatPayBaseRequest
@property (nonatomic,  copy) NSString* scope;
@property (nonatomic,  copy) NSString* state;
@end

/**
 微信终端返回给第三方认证的消息结构
 */
@interface KKWechatAuthorResponse : KKWechatPayBaseResponse
@property (nonatomic,  copy) NSString* scope;
@property (nonatomic,  copy) NSString* state;
@property (nonatomic,  copy) NSString* lang;
@property (nonatomic,  copy) NSString* country;
@end



NS_ASSUME_NONNULL_END
