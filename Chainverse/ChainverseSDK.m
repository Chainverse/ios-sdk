//
//  ChainverseSDK.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "ChainverseSDK.h"
#import "UIKit/UIKit.h"
#import "CVSDKTrustConnect.h"
#import "CVSDKTrustTransfer.h"
#import "CVSDKUtils.h"
#import "CVSDKChooseWLViewDialog.h"
#import "CVSDKBaseSocketManager.h"
#import "CVSDKRPCClient.h"
#import "ContractManager.h"
@interface ChainverseSDK()
@property (nonatomic, nonatomic) CVSDKBaseSocketManager *manager;
@end
@implementation ChainverseSDK

+ (ChainverseSDK *)shared{
    static ChainverseSDK *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)init:(NSString *)developerAddress gameAddress:(NSString *)gameAddress{
    
    ContractManager *contractManager = [[ContractManager alloc] init];
    contractManager.developerAddress = developerAddress;
    contractManager.gameAddress = gameAddress;
    [contractManager check:^(BOOL isChecked){
        if(isChecked){
            [self doInit];
        }
    }];
}

- (void)doInit{
    NSLog(@"nampv_init");
}


- (void)testSocket{
    self.manager = [[CVSDKBaseSocketManager alloc] init];
    [self.manager on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket_x connected");
        [self.manager on:@"server-to-client" callback:^(NSArray* data, SocketAckEmitter* ack){
            NSLog(@"socket_x connected %@",data);
            if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didSocketCallback:)]){
                [[ChainverseSDK shared].delegate didSocketCallback:data];
            }
        }];
    }];
    
    [self.manager connect];
}
- (BOOL)application:(UIApplication *)app
              openURL:(NSURL *)url
              options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    NSString *accounts = [CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"];
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didConnectWallet:)]){
        [[ChainverseSDK shared].delegate didConnectWallet:accounts];
    }
    return true;
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts{
    UIOpenURLContext *context = URLContexts.allObjects.firstObject;
    NSString *accounts = [CVSDKUtils getValueFromQueryParam:context.URL withParam:@"accounts"];
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didConnectWallet:)]){
        [[ChainverseSDK shared].delegate didConnectWallet:accounts];
    }
}

- (NSString *)getVersion{
    return @"1.0.1";
}

- (void)chooseWL{
    [CVSDKChooseWLViewDialog showChooseView];
}

- (void)connectTrust{
    CVSDKTrustConnect *trust = [[CVSDKTrustConnect alloc] init];
    trust.scheme = @"trustsdk";
    [trust connect];
}

- (void)transferTrust:(NSString *)asset
                   to:(NSString *)to
               amount:(NSString *)amount
             feePrice:(NSString *)feePrice
             feeLimit:(NSString *)feeLimit{
    CVSDKTrustTransfer *trust = [[CVSDKTrustTransfer alloc] init];
    trust.scheme = @"trustsdk";
    trust.asset = asset;
    trust.to = to;
    trust.amount = amount;
    trust.feePrice = feePrice;
    trust.feeLimit = feeLimit;
    [trust transfer];
}
@end
