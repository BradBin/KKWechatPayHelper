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
 支付回调block
 */
@property (nonatomic,  copy) KKWechatPayBlock completionBlock;

@end

@implementation KKWechatPayManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mode = KKWechatPayModeProduct;
        [WXApi stopLog];
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
                NSLog(@"************普通日志默认****************\n %@ \n************************************",log);
            }];
            break;
            case KKWechatPayModeDetail:
            [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
                NSLog(@"************详细日志默认****************\n %@ \n************************************",log);
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

-(BOOL)payOrder:(KKWechatPayRequest *)request completion:(KKWechatPayBlock)completion{
    self.completionBlock = completion;
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

/*************WXApiDelegate********************/
- (void)onReq:(BaseReq*)req{
    
}

- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:PayResp.class]) {
        if (self.completionBlock) {
            self.completionBlock(resp.errCode,nil);
        }
    }
}

@end
