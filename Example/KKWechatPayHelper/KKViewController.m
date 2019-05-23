//
//  KKViewController.m
//  KKWechatPayHelper
//
//  Created by BradBin on 05/19/2019.
//  Copyright (c) 2019 BradBin. All rights reserved.
//

#import "KKViewController.h"
#import <YYKit/YYKit.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import <KKWechatPayHelper/KKWechatPayHelper.h>

@interface KKViewController ()

@property (nonatomic,strong) UIButton *wechatBtn;

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.wechatBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 8.0;
        button.layer.masksToBounds = true;
        button.titleLabel.adjustsFontSizeToFitWidth = true;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:@"微信支付" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#46B942"]]
                          forState:UIControlStateNormal];
        [button addTarget:self action:@selector(kk_wechartPayEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(button.superview.mas_safeAreaLayoutGuideBottom).offset(-30);
            } else {
                make.bottom.equalTo(button.superview.mas_bottom).offset(-30);
            }
            make.centerX.equalTo(button.superview.mas_centerX);
            make.width.equalTo(button.superview.mas_width).multipliedBy(0.75);
            make.height.mas_equalTo(@50);
        }];
        button;
    });
    
}


- (void)kk_wechartPayEvent:(UIButton *)sender{
    
    NSString *urlString   = @"https://wxpay.wxutil.com/pub_v2/app/app_pay.php?plat=ios";
    AFHTTPSessionManager *manager = AFHTTPSessionManager.manager;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    @weakify(self);
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self);
        KKPayItem *payItem = [KKPayItem modelWithJSON:responseObject];
        [self kk_wechatPayWithKKPayItem:payItem];
        NSLog(@"responseObject --- %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error --- %@",error.localizedDescription);
    }];
}


-(void)kk_wechatPayWithKKPayItem:(KKPayItem *)payItem{
    KKWechatPayRequest *request = KKWechatPayRequest.new;
    request.openID    = payItem.appid;
    request.partnerId = payItem.partnerid;
    request.prepayId  = payItem.prepayid;
    request.nonceStr  = payItem.noncestr;
    request.timeStamp = payItem.timestamp;
    request.package   = payItem.package;
    request.sign      = payItem.sign;
    [KKWechatPayManager.shared payOrder:request success:^(KKWechatPayStatus status, KKWechatPayResponse * _Nonnull response) {
        NSLog(@"success*****%ld   %@",(long)status,response.modelDescription);
    } failure:^(KKWechatPayStatus status, KKWechatPayResponse * _Nonnull response) {
        NSLog(@"failure*****%ld   %@",(long)status,response.modelDescription);
    }];
}

//wxlog:has call system function

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




@implementation KKPayItem


@end
