//
//  KKWechatPayManager.m
//  KKWechatPayHelper
//
//  Created by Macbook Pro 15.4  on 2019/5/19.
//

#import "KKWechatPayManager.h"
#import <WechatOpenSDK/WXApi.h>
#import <WechatOpenSDK/WechatAuthSDK.h>

@interface KKWechatPayManager()<WXApiDelegate>

/**
 默认:fasle正式环境
 */
@property (nonatomic,assign) KKWechatPayMode mode;

/**
 成功回调block
 */
@property (nonatomic,  copy) KKWechatPayBlock success;
/**
 失败回调block
 */
@property (nonatomic,  copy) KKWechatPayBlock failure;

@end

@implementation KKWechatPayManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mode = KKWechatPayModeProduct;
        [WXApi stopLog];
#if TARGET_IPHONE_SIMULATOR
         NSLog(@"\n************KKWechatPayHelper****************\n\n %@ \n\n************************************",@"模拟器不支持微信相关操作,请使用真机测试!!!");
#endif
    }
    return self;
}

+(instancetype)shared{
    static KKWechatPayManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

-(BOOL)registerApp:(NSString *)appid enableMTA:(BOOL)isEnableMTA{
    return [WXApi registerApp:appid enableMTA:isEnableMTA];
}

- (void)setWechatPayMode:(KKWechatPayMode)mode{
    _mode = mode;
    switch (mode) {
            case KKWechatPayModeProduct:
            [WXApi stopLog];
            break;
            case KKWechatPayModeNormal:
            [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString * _Nonnull log) {
                NSLog(@"\n************KKWechatPayHelper(普通日志默认)****************\n\n %@ \n\n************************************",log);
            }];
            break;
            case KKWechatPayModeDetail:
            [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
                NSLog(@"\n************KKWechatPayHelper(详细日志默认)****************\n\n %@ \n\n************************************",log);
            }];
            break;
        default:
            break;
    }
}

-(BOOL)isWechatAppInstalled{
    return [WXApi isWXAppInstalled];
}

-(NSURL *)getWechatAppInstallUrl{
    return [NSURL URLWithString:WXApi.getWXAppInstallUrl];
}

-(BOOL)payOrder:(KKWechatPayRequest *)request success:(KKWechatPayBlock)success failure:(KKWechatPayBlock)failure{
    self.success  = success;
    self.failure  = failure;
    PayReq *req   = PayReq.alloc.init;
    req.partnerId = request.partnerId;
    req.prepayId  = request.prepayId;
    req.nonceStr  = request.nonceStr;
    req.timeStamp = request.timeStamp;
    req.package   = request.package;
    req.sign      = request.sign;
    return [WXApi sendReq:req];
}

-(BOOL)handleOpenURL:(NSURL *)url{
    BOOL result = [WXApi handleOpenURL:url delegate:self];
    return result;
}

-(BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication{
    BOOL result = [WXApi handleOpenURL:url delegate:self];
    return result;
}

- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL result = [WXApi handleOpenURL:url delegate:self];
    return result;
}

/*************WXApiDelegate********************/
- (void)onReq:(BaseReq*)req{
    
}

- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:PayResp.class]) {
        if (self.success || self.failure) {
            PayResp *payResp   = (PayResp *)resp;
            NSString *errMsg   = [payResp.errStr stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
            KKWechatPayStatus status      = (KKWechatPayStatus)payResp.errCode;
            KKWechatPayResponse *response = KKWechatPayResponse.new;
            response.errCode              = payResp.errCode;
            response.type                 = payResp.type;
            response.returnKey            = payResp.returnKey;
            switch (status) {
                case KKWechatPayStatusSuccess:
                    response.errStr = errMsg.length ? errMsg: @"支付成功";
                    self.success(KKWechatPayStatusSuccess, response);
                    break;
                case KKWechatPayStatusFailure:
                    response.errStr = errMsg.length ? errMsg: @"支付失败";
                    self.failure(KKWechatPayStatusFailure, response);
                    break;
                case KKWechatPayStatusCancel:
                    response.errStr = errMsg.length ? errMsg: @"支付取消";
                    self.failure(KKWechatPayStatusCancel, response);
                    break;
                default:
                    response.errStr = errMsg;
                    self.failure(KKWechatPayStatusUnknown, response);
                    break;
            }
            
        }
    }else{
        if (self.failure) {
            KKWechatPayResponse *response = KKWechatPayResponse.new;
            response.errCode = @(KKWechatPayStatusUnknown).integerValue;
            response.errStr  = @"未知错误";
            self.failure(KKWechatPayStatusUnknown, response);
        }
    }
}

@end
