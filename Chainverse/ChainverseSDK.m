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
#import "CVSDKTrustSignMessage.h"
#import "CVSDKUtils.h"
#import "CVSDKChooseWLViewDialog.h"
#import "CVSDKBaseSocketManager.h"
#import "CVSDKRPCClient.h"
#import "ContractManager.h"
#import "Chainverse_SDK-Swift.h"
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

- (void)start{
    ContractManager *contractManager = [[ContractManager alloc] init];
    contractManager.developerAddress = self.developerAddress;
    contractManager.gameAddress = self.gameAddress;
    [contractManager check:^(BOOL isChecked){
        if(isChecked){
            [self doInit];
        }
    }];
}

- (void)doInit{
    NSLog(@"sdk_init");
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

- (void)doHandleOpenUrl :(NSURL *)url{
    //Callback get account from Trust Wallet
    if(![[CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"] isEqualToString:@""]){
        CVSDKTrustSignMessage *trust = [[CVSDKTrustSignMessage alloc] init];
        CVSDKHash *hash = [[CVSDKHash alloc] init];
        trust.data = [hash keccak256:_gameAddress];
        [trust signMessage];
    }else if(![[CVSDKUtils getValueFromQueryParam:url withParam:@"signature"] isEqualToString:@""]){
        //Callback Signature from Trust Wallet
        NSString *signature = [CVSDKUtils getValueFromQueryParam:url withParam:@"signature"];
        NSLog(@"nampv_sig %@",signature);
    }
    
    if([[ChainverseSDK shared].delegate respondsToSelector:@selector(didConnectWallet:)]){
        [[ChainverseSDK shared].delegate didConnectWallet:[CVSDKUtils getValueFromQueryParam:url withParam:@"accounts"]];
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
