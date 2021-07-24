//
//  ChainverseSDK.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "ChainverseSDK.h"
#import "UIKit/UIKit.h"
#import "CVSDKTrustConnect.h"
#import "CVSDKTrustSignMessage.h"
#import "CVSDKUtils.h"
#import "CVSDKConnectWalletDialog.h"
#import "CVSDKBaseSocketManager.h"
#import "CVSDKRPCClient.h"
#import "ContractManager.h"
#import "CVSDKBridging.h"
#import "CVSDKUserDefault.h"
#import "CVSDKTrustResult.h"
#import "CVSDKDefine.h"
#import "CVSDKCallbackToGame.h"
#import "ChainverseSDKError.h"
@interface ChainverseSDK(){
    BOOL isInitSDK;
}
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

- (void)initialize{
    isInitSDK = false;
    self.isKeepConnectWallet = TRUE;
    [self checkContract];
}

- (void)checkContract{
    ContractManager *contractManager = [[ContractManager alloc] init];
    [contractManager check:^(BOOL isChecked){
        if(isChecked){
            [CVSDKCallbackToGame didInitSDKSuccess];
            [self doInitialize];
        }else{
            [CVSDKCallbackToGame didError:Error_InitSDK];
        }
    }];
}

- (void)doInitialize{
    isInitSDK = true;
    if(self.isKeepConnectWallet){
        [CVSDKCallbackToGame didUserAddress:[CVSDKUserDefault getXUserAdress]];
    }else{
        [CVSDKUserDefault clearXUserAddress];
    }
}


- (void) setKeepConnectWallet:(BOOL)isKeep{
    self.isKeepConnectWallet = isKeep;
}

- (void) logout{
    if(![self isInitSDKSuccess]){
        return;
    }
    [CVSDKCallbackToGame didUserLogout:[CVSDKUserDefault getXUserAdress]];
    [CVSDKUserDefault clearXUserAddress];
}

- (NSString *)getUser{
    return [CVSDKUserDefault getXUserAdress];
}

- (BOOL)handleOpenUrl:(UIApplication *)app
              openURL:(NSURL *)url
              options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    [self doHandleOpenUrl:url];
    return true;
}

- (void)handleOpenUrl:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts NS_AVAILABLE_IOS(13_0){
    UIOpenURLContext *context = URLContexts.allObjects.firstObject;
    [self doHandleOpenUrl:context.URL];
}

-(BOOL)handleOpenUrl:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation{
    [self doHandleOpenUrl:url];
    return true;
}

- (void)doHandleOpenUrl :(NSURL *)url{
    int action = [CVSDKTrustResult getAction:url];
    switch (action) {
        case TrustAccount:{
            NSString *xUserAddress = [CVSDKTrustResult getUserAddress:url];
            [CVSDKUserDefault setXUserAddress:xUserAddress];
            CVSDKTrustSignMessage *trust = [[CVSDKTrustSignMessage alloc] init];
            trust.data = [CVSDKBridging keccak256:_gameAddress];
            [trust signMessage];
            break;
        }
        case TrustSignature: {
            NSString *signature = [CVSDKTrustResult getSignature:url];
            [CVSDKUserDefault setXUserSignature:signature];
            [CVSDKCallbackToGame didUserAddress:[CVSDKUserDefault getXUserAdress]];
            break;
        }
        default:
            break;
    }
}

- (NSString *)getVersion{
    return @"1.0.1";
}

- (void)showConnectWalletView{
    if(![self isInitSDKSuccess]){
        return;
    }
    [CVSDKConnectWalletDialog showConnectView];
}

- (void)connectTrust{
    if(![self isInitSDKSuccess]){
        return;
    }
    CVSDKTrustConnect *trust = [[CVSDKTrustConnect alloc] init];
    [trust connect];
}

- (BOOL)isInitSDKSuccess{
    if(!isInitSDK){
        [CVSDKCallbackToGame didError:Error_InitSDK];
        return false;
    }
    return true;
}
@end
