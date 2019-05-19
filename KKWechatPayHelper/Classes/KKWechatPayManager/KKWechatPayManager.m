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
    if ([req isKindOfClass:PayResp.class]) {
        
    }
}

- (void)onResp:(BaseResp *)resp{
    
}

@end
