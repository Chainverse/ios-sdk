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
#import "CVSDKBaseSocketIO.h"
#import "CVSDKRPCClient.h"
#import "CVSDKContractManager.h"
#import "CVSDKBridging.h"
#import "CVSDKUserDefault.h"
#import "CVSDKTrustResult.h"
#import "CVSDKDefine.h"
#import "CVSDKCallbackToGame.h"
#import "ChainverseSDKError.h"
#import "CVSDKRESTfulClient.h"
#import "CVSDKParseJson.h"
#import "CVSDKConstant.h"
#import "ChainverseItem.h"
#import "CVSDKChainverseConnect.h"
#import "CVSDKChainverseResult.h"
#import "CVSDKTransferItemManager.h"
#import "ChainverseVersion.h"
#import "CVSDKWalletCreateScreen.h"
#import "CVSDKWalletBackupScreen.h"
#import "CVSDKWalletVerifyScreen.h"
#import "CVSDKWalletConnectScreen.h"
#import "CVSDKWalletInfoScreen.h"
#import "CVSDKWeb3.h"
#import "CVSDKWallet.h"
@interface ChainverseSDK(){
    BOOL isInitSDK;
}
@property (nonatomic, nonatomic) CVSDKBaseSocketIO *socketIO;
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
    self.isKeepConnect = TRUE;
    //[self checkContract];
    [CVSDKCallbackToGame didInitSDKSuccess];
    [self doInitialize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSuccessNotification:) name:NOTIFICATION_CONNECT_SUCCESS object:nil];
    
   
//    NSString *signedMessage = [CVSDKWallet signFuck:[CVSDKUserDefault getMnemonic]];
//    NSString *signedMessage = [CVSDKWallet signMessage:@"chainverse"];
//    NSLog(@"nampv_signmessage %@",signedMessage);
}

- (void) connectSuccessNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:NOTIFICATION_CONNECT_SUCCESS]){
        [self doConnectSuccess];
    }
}


- (void)checkContract{
    CVSDKContractManager *contractManager = [[CVSDKContractManager alloc] init];
    [contractManager check:^(BOOL isChecked){
        if(isChecked){
            [CVSDKCallbackToGame didInitSDKSuccess];
            [self doInitialize];
        }else{
            [CVSDKCallbackToGame didError:ERROR_INIT_SDK];
        }
    }];
}

- (void)doInitialize{
    isInitSDK = true;
    if(self.isKeepConnect){
        [self doConnectSuccess];
    }else{
        [CVSDKUserDefault clearXUserAddress];
        [CVSDKUserDefault clearXUserSignature];
    }
}

- (void)doConnectSuccess{
    
    if([self isUserConnected]){
        NSLog(@"chainversesdk_connect_success %@",[CVSDKUserDefault getXUserSignature]);
        NSLog(@"chainversesdk_connect_address %@",[CVSDKUserDefault getXUserAdress]);
        [CVSDKCallbackToGame didConnectSuccess:[CVSDKUserDefault getXUserAdress]];
        [[CVSDKTransferItemManager shared] on:^(int event,NSArray * _Nonnull data){
            switch (event) {
                case EVENT_TRANSFER_ITEM_TO_USER:
                    if([data count] > 0){
                        [CVSDKCallbackToGame didItemUpdate:[CVSDKParseJson parseItem:data] type:TRANSFER_ITEM_TO_USER];
                        [self getItems];
                    }
                    break;
                    
                case EVENT_TRANSFER_ITEM_FROM_USER:
                    if([data count] > 0){
                        [CVSDKCallbackToGame didItemUpdate:[CVSDKParseJson parseItem:data] type:TRANSFER_ITEM_FROM_USER];
                        [self getItems];
                    }
                    break;
                    
                default:
                    break;
            }
        }];
        [[CVSDKTransferItemManager shared] connect];
    }
}

- (void) setKeepConnect:(BOOL)isKeep{
    self.isKeepConnect = isKeep;
}

- (void) logout{
    if(![self isInitSDKSuccess]){
        return;
    }
    [CVSDKCallbackToGame didLogout:[CVSDKUserDefault getXUserAdress]];
    [CVSDKUserDefault clearXUserAddress];
    [CVSDKUserDefault clearXUserSignature];
}


- (void)getItems{
    if(![self isInitSDKSuccess]){
        return;
    }
    
    if([self isUserConnected]){
        NSString *action = [NSString stringWithFormat:actionItems, [CVSDKUserDefault getXUserAdress], [ChainverseSDK shared].gameAddress];
        [[CVSDKRESTfulClient shared] get:action completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"nampv_getItems %@",responseObject);
            if([CVSDKParseJson errorCode:responseObject] == 0){
                NSMutableArray *items = [CVSDKParseJson parseItems:responseObject];
                [CVSDKCallbackToGame didGetItems:items];
            }else{
                [CVSDKCallbackToGame didError:ERROR_REQUEST_ITEM];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"nampv_getItems_r %@",error);
            [CVSDKCallbackToGame didError:ERROR_REQUEST_ITEM];
        }];
    } else {
        [CVSDKCallbackToGame didError:ERROR_DEVELOPER_PAUSE];
    }
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
    NSLog(@"nampv_chainverse_url %@",url);
    if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"trust"]){
        int action = [CVSDKTrustResult getAction:url];
        switch (action) {
            case TrustAccount:{
                NSString *xUserAddress = [CVSDKTrustResult getUserAddress:url];
                [CVSDKUserDefault setXUserAddress:xUserAddress];
                CVSDKTrustSignMessage *trust = [[CVSDKTrustSignMessage alloc] init];
                //NSString *message = [NSString stringWithFormat:@"get_game_user_item:%@",_gameAddress];
                trust.data = [CVSDKBridging keccak256:@"chainverse"];
                //trust.data = @"chainverse";
                [trust signMessage];
                break;
            }
            case TrustSignature: {
                NSString *signature = [NSString stringWithFormat:@"%@",[CVSDKTrustResult getSignature:url]];
                [CVSDKUserDefault setXUserSignature:signature];
                [self doConnectSuccess];
                break;
            }
            default:
                break;
        }
    }else{
        //Connect Chainverse
        NSString *xUserAddress = [CVSDKChainverseResult getUserAddress:url];
        [CVSDKUserDefault setXUserAddress:xUserAddress];
        NSString *signature = [NSString stringWithFormat:@"0x%@",[CVSDKChainverseResult getSignature:url]];
        [CVSDKUserDefault setXUserSignature:signature];
        [self doConnectSuccess];
    }
    
}

- (NSString *)getVersion{
    return version;
}

- (void)showConnectView{
    if(![self isInitSDKSuccess]){
        return;
    }
    [CVSDKConnectWalletDialog showConnectView];
}

- (void)connectWithTrust{
    if(![self isInitSDKSuccess]){
        return;
    }
    [CVSDKUserDefault setConnectWallet:@"trust"];
    CVSDKTrustConnect *trust = [[CVSDKTrustConnect alloc] init];
    [trust connect];
}

- (void)connectWithChainverse{
    if(![self isInitSDKSuccess]){
        return;
    }
    if([CVSDKUtils isChainverseInstalled]){
        [CVSDKUserDefault setConnectWallet:@"chainverse"];
        CVSDKChainverseConnect *chainverse = [[CVSDKChainverseConnect alloc] init];
        chainverse.data = [CVSDKBridging keccak256:@"chainverse"];
        [chainverse connect];
    }
    
}

- (BOOL)isInitSDKSuccess{
    if(!isInitSDK){
        [CVSDKCallbackToGame didError:ERROR_WAITING_INIT_SDK];
        return false;
    }
    return true;
}

- (BOOL)isUserConnected{
    if([CVSDKUserDefault getXUserSignature] != nil){
        return true;
    }
    return false;
}

- (ChainverseUser *)getUser{
    if([self isUserConnected]){
        NSDictionary *dict = @{ @"address" : [CVSDKUserDefault getXUserAdress], @"signature" : [CVSDKUserDefault getXUserSignature]};
        ChainverseUser *user = [[ChainverseUser alloc] initWithObjectDict:dict];
        [ChainverseUser archiveObject:user];
        return user;
    }
    return nil;
}

- (void)testPurchase{
    NSMutableDictionary *obj = [NSMutableDictionary dictionary];
    obj[@"to"] = [ChainverseSDK shared].developerAddress;
    obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isDeveloperContract()" address:@""];
    
    [[CVSDKRESTfulClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        NSLog(@"nampv_fu %@",responseObject);
        if (!error) {
            
        }
    }];
}

- (void) showConnectWalletView{
    [CVSDKWalletConnectScreen open];
}

- (void)showWalletInfoView{
    [CVSDKWalletInfoScreen open];
}
@end
