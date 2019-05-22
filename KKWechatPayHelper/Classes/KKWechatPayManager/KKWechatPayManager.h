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

/**
 支付结果枚举

 - KKWechatPayStatusSuccess: 成功,展示成功页面
 - KKWechatPayStatusFailure: 错误,可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。
 - KKWechatPayStatusCancel: 用户取消,无需处理。发生场景：用户不支付了，点击取消，返回APP。
 - KKWechatPayStatusUnknown: 未知错误
 */
typedef NS_ENUM(NSInteger,KKWechatPayStatus) {
    KKWechatPayStatusSuccess =  0,
    KKWechatPayStatusFailure = -1,
    KKWechatPayStatusCancel  = -2,
    KKWechatPayStatusUnknown = -100
};

/**
 支付回调block
 
 @param status 支付结果状态
 @param response response
 */
typedef void(^ _Nullable KKWechatPayBlock)(KKWechatPayStatus status,KKWechatPayResponse *response);

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
 启动第三方应用程序时调用。第一次调用后，会在微信的可用应用列表中出现
 备注:确保证在主线程中调用此函数
 @param appid 微信开发者ID
 @param isEnableMTA 是否支持MTA数据上报
 @return 成功返回YES，失败返回NO。
 */
- (BOOL)registerApp:(NSString *)appid enableMTA:(BOOL)isEnableMTA;

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
 获取微信的itunes的链接地址

 @return 链接地址
 */
- (NSURL *)getWechatAppInstallUrl;

/**
 发起微信支付请求
 备注:支付成功则去后台查询支付结果,再去展示给用户实际支付结果页面,一定
 不能以客户端返回作为用户支付结果

 @param request 请求内容
 @param completion 请求结果回调block
 @return 成功返回YES，失败返回NO
 */
- (BOOL)payOrder:(KKWechatPayRequest *)request completion:(KKWechatPayBlock)completion;

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




/**
 处理客户端回调
 -(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
 @param url url
 @return 回调结果
 */
- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;


@end

NS_ASSUME_NONNULL_END
