//
//  KKWechatPayManager.h
//  KKWechatPayHelper
//
//  Created by Macbook Pro 15.4  on 2019/5/19.
//

#import <Foundation/Foundation.h>
#import "KKWechatPayItem.h"

NS_ASSUME_NONNULL_BEGIN


/**
 微信SDK的模式 默认:生产模式,不打印日志

 - KKWechatPayModeProduct: 生产模式
 - KKWechatPayModeNormal: 普通输出日志模式
 - KKWechatPayModeDetail: 详细输出日志模式
 */
typedef NS_ENUM(NSUInteger,KKWechatPayMode) {
    KKWechatPayModeProduct = 0,
    KKWechatPayModeNormal,
    KKWechatPayModeDetail
};

typedef NS_ENUM(NSInteger,KKWechatPayStatus) {
    KKWechatPayStatusSuccess,        //支付成功
    KKWechatPayStatusFailure,        //支付失败
    KKWechatPayStatusCancel,         //支付取消
    KKWechatPayStatusUnknownCancel   //支付取消，交易已发起，状态不确定，商户需查询商户后台确认支付状态
};

/**
 支付回调block
 
 @param status 支付结果状态
 @param dict dict
 */
typedef void(^ _Nullable KKWechatPayBlock)(KKWechatPayStatus status,NSDictionary *dict);

@interface KKWechatPayManager : NSObject

/**
 微信SDK的模式
 */
@property (nonatomic,assign,readonly) KKWechatPayMode mode;

/**
 单例对象
 
 @return 单例对象
 */
+ (instancetype)shared;

/**
 微信SDK的运行模式,默认是生产模式

 @param mode 运行模式
 */
- (void)setWechatPayMode:(KKWechatPayMode)mode;

/**
 是否安装微信app,默认是false:没有安装
 
 @return  是否安装微信
 */
- (BOOL)isWechatAppInstalled;


/**
 处理客户端回调
 - (BOOL)application(UIApplication *)application openURL:(NSURL *)url
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 @param url url
 @return 回调结果
 */
- (BOOL)handleOpenURL:(NSURL *)url;

/**
 处理客户端回调
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 @param url url
 @return 回调结果
 */
- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;


@end

NS_ASSUME_NONNULL_END
