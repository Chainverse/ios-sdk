//
//  ChainverseSDK.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "ChainverseSDK.h"
#import "UIKit/UIKit.h"
#import "CVSDKUtils.h"
#import "CVSDKBaseSocketIO.h"
#import "CVSDKRPCClient.h"
#import "CVSDKContractManager.h"
#import "CVSDKUserDefault.h"
#import "CVSDKDefine.h"
#import "CVSDKCallbackToGame.h"
#import "ChainverseSDKError.h"
#import "CVSDKRESTfulClient.h"
#import "CVSDKParseJson.h"
#import "CVSDKConstant.h"
#import "ChainverseItem.h"
#import "CVSDKChainverseApp.h"
#import "CVSDKChainverseAppResult.h"
#import "CVSDKTransferItemManager.h"
#import "ChainverseVersion.h"
#import "CVSDKWalletCreateScreen.h"
#import "CVSDKWalletBackupScreen.h"
#import "CVSDKWalletVerifyScreen.h"
#import "CVSDKWalletConnectScreen.h"
#import "CVSDKWalletInfoScreen.h"
#import "CVSDKBridgingWeb3.h"
#import "CVSDKBridgingWallet.h"
#import "CVSDKSignMessageScreen.h"
#import "CVSDKRESTfulClientEndpoint.h"
#import "CVSDKNonce.h"
#import "CVSDKNFTResult.h"
#import "CVSDKNFTDetail.h"
#import "CVSDKContractConfirmScreen.h"
#import "CVSDKContractConfirmInput.h"
#import "ChainverseTokenSupport.h"


#import "NFT.h"
#import "InfoSell.h"
#import "Currency.h"
#import "CVSDKServiceGame.h"
@interface ChainverseSDK(){
    BOOL isInitSDK;
    
}
@property (nonatomic, nonatomic) CVSDKBaseSocketIO *socketIO;
@property (nonatomic, nonatomic) NSString *updateRPC;
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
    [self receiverNotificationConnect];
    [self getServiceByGame];
}

- (void) receiverNotificationConnect{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSuccessNotification:) name:NOTIFICATION_CONNECT_SUCCESS object:nil];
}
- (void)getServiceByGame{
    NSString *action = [NSString stringWithFormat:getServiceByGameEndpoint, [ChainverseSDK shared].gameAddress];
    [[CVSDKRESTfulClient marketShared] getServiceByGame:action completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([CVSDKParseJson errorCode:responseObject] == 0){
            if (responseObject[@"data"]){
                CVSDKServiceGame *serviceGame = [[CVSDKServiceGame alloc] initWithObjectDict:responseObject[@"data"]];
                NSArray *arrayRpcs = serviceGame.rpcs;
                if(arrayRpcs.count > 0){
                    NSString *rpc = arrayRpcs.firstObject;
                    //initSDK
                    [[CVSDKBridgingWallet shared] initialize];
                    [[CVSDKBridgingWeb3 shared] initialize:rpc];
                    [self checkInitSDK];
                    [self doInitialize];
                    [CVSDKServiceGame archiveObject:serviceGame];
                    
                    [self checkRPC];
                }else{
                    [CVSDKCallbackToGame didError:ERROR_SERVICE_NOT_FOUND];
                }
                
            }else{
                [CVSDKCallbackToGame didError:ERROR_SERVICE_NOT_FOUND];
            }

        }else{
            [CVSDKCallbackToGame didError:ERROR_SERVICE_NOT_FOUND];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CVSDKCallbackToGame didError:ERROR_SERVICE_NOT_FOUND];
    }];
}

- (void)checkRPC{
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.chainverse.check.rpc", NULL);
    dispatch_async(backgroundQueue, ^{
        
        CVSDKServiceGame *serviceGame = [CVSDKServiceGame getArchivedObjectWithClass:[CVSDKServiceGame class]];
        NSArray *arrayRpcs = serviceGame.rpcs;
        NSInteger block = 0;
        if(arrayRpcs.count > 0){
            for(int i = 0;i < arrayRpcs.count ; i++){
                NSInteger newBlock = [[CVSDKBridgingWeb3 shared] getBlockNumber:arrayRpcs[i]];
                if(newBlock > block){
                    block = newBlock;
                    self.updateRPC = arrayRpcs[i];
                    
                }
                NSLog(@"chainverse_rpc %@ %li",arrayRpcs[i], newBlock);
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CVSDKBridgingWeb3 shared] initialize:self.updateRPC];
            NSLog(@"chainverse_rpc_update %@",self.updateRPC);
        });
       
    });
}


- (void) connectSuccessNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:NOTIFICATION_CONNECT_SUCCESS]){
        [self doConnectSuccess];
    }
}


- (void)checkInitSDK{
    [[CVSDKContractManager shared] checkInitSDK:^(BOOL isChecked){
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
        [self setAccessToken];
        [CVSDKCallbackToGame didConnectSuccess:[CVSDKUserDefault getXUserAdress]];
        NSLog(@"nampv_signature %@",[CVSDKUserDefault getXUserSignature]);
        [[CVSDKTransferItemManager shared] on:^(int event,NSArray * _Nonnull data){
            switch (event) {
                case EVENT_TRANSFER_ITEM_TO_USER:
                    if([data count] > 0){
                        [CVSDKCallbackToGame didItemUpdate:[CVSDKParseJson parseItem:data] type:TRANSFER_ITEM_TO_USER];
                    }
                    break;
                    
                case EVENT_TRANSFER_ITEM_FROM_USER:
                    if([data count] > 0){
                        [CVSDKCallbackToGame didItemUpdate:[CVSDKParseJson parseItem:data] type:TRANSFER_ITEM_FROM_USER];
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
    [CVSDKUserDefault clearXUserSignature];
    [CVSDKCallbackToGame didLogout:[CVSDKUserDefault getXUserAdress]];
    [CVSDKUserDefault clearXUserAddress];
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
    
    if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"account_sign_message"]){
        NSString *xUserAddress = [CVSDKChainverseAppResult getUserAddress:url];
        [CVSDKUserDefault setXUserAddress:xUserAddress];
        [CVSDKUserDefault setXUserSignature:[CVSDKChainverseAppResult getSignature1:url]];
        
        [CVSDKUserDefault setXUserTime:[CVSDKChainverseAppResult getTime:url]];
        [CVSDKUserDefault setXUserNonce:[CVSDKChainverseAppResult getNonce:url]];
        [CVSDKUserDefault setXUserSignatureV2:[CVSDKChainverseAppResult getSignature0:url]];
        [self doConnectSuccess];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"sdk_sign_message"]){
        [CVSDKCallbackToGame didSignMessage:[CVSDKChainverseAppResult getSignature:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"approveToken"]){
        [CVSDKCallbackToGame didTransact:approveToken tx:[CVSDKChainverseAppResult getData:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"approveNFT"]){
        [CVSDKCallbackToGame didTransact:approveNFT tx:[CVSDKChainverseAppResult getData:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"buyNFT"]){
        [CVSDKCallbackToGame didTransact:buyNFT tx:[CVSDKChainverseAppResult getData:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"bidNFT"]){
        [CVSDKCallbackToGame didTransact:bidNFT tx:[CVSDKChainverseAppResult getData:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"sellNFT"]){
        [CVSDKCallbackToGame didTransact:sellNFT tx:[CVSDKChainverseAppResult getData:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"cancelSell"]){
        [CVSDKCallbackToGame didTransact:cancelSell tx:[CVSDKChainverseAppResult getData:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"withdrawItem"]){
        [CVSDKCallbackToGame didTransact:withdrawItem tx:[CVSDKChainverseAppResult getData:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"moveService"]){
        [CVSDKCallbackToGame didTransact:moveService tx:[CVSDKChainverseAppResult getData:url]];
    }else if([[CVSDKChainverseAppResult getAction:url] isEqualToString:@"transferItem"]){
        [CVSDKCallbackToGame didTransact:transferItem tx:[CVSDKChainverseAppResult getData:url]];
    }
    
    
}

- (NSString *)getVersion{
    return version;
}



- (void)connectWithChainverse{
    if(![self isInitSDKSuccess]){
        return;
    }
    if([CVSDKUtils isChainverseInstalled]){
        [CVSDKUserDefault setConnectWallet:@"ChainverseApp"];
        [CVSDKChainverseApp connect];
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


- (void) showConnectWalletView{
    [CVSDKUserDefault setConnectWallet:@"ChainverseSDK"];
    [CVSDKWalletConnectScreen open];
}

- (void)showWalletInfoView{
    [CVSDKWalletInfoScreen open];
}

- (NSString *)getBalance{
    return [[CVSDKBridgingWeb3 shared] getBalance:[CVSDKUserDefault getXUserAdress]];
}

- (NSMutableArray<Currency> *)getListCurrencies{
    //CVSDKGameServiceData *data = [CVSDKUserDefault getGameService];
    NSMutableArray<Currency> *currencies = [NSMutableArray<Currency> array] ;
    /*if([[data data] tokens].count > 0){
        for(ChainverseToken *item in [[data data] tokens]){
            Currency *currency = [[Currency alloc] init];
            currency.currency = item.address;
            currency.name = item.name;
            currency.symbol = item.symbol;
            currency.decimal = item.decimals;
            
            [currencies addObject:currency];
            
        }
    }*/
    return currencies;
}

- (NSString *)getBalance:(NSString *)contractAddress{
    return  [[CVSDKBridgingWeb3 shared] getBalance:contractAddress owner:[CVSDKUserDefault getXUserAdress]];
}

- (void)signMessage:(NSString *)message{
    if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseSDK"]){
        NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] init];
        [inputDic setObject:message forKey:@"message"];
        [inputDic setObject:@"message" forKey:@"type"];
        [CVSDKSignMessageScreen showSignerView:inputDic];
    }else{
        [CVSDKChainverseApp signMessage:message];
    }
}

- (void)signTransaction:(NSString *)nonce gasPrice:(NSString *)gasPrice gasLimit:(NSString *)gasLimit toAddress:(NSString *)toAddress amount:(NSString *)amount chainID:(NSString *)chainID templateData:(NSData *)templateData{
    
    NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] init];
    [inputDic setObject:@"fuck" forKey:@"message"];
    [inputDic setObject:@"message" forKey:@"type"];
    //[CVSDKContractCallConfirmScreen showSignerView:inputDic];
    //[[CVSDKBridgingWeb3 shared] signTransaction:nonce gasPrice:gasPrice gasLimit:gasLimit toAddress:toAddress value:amount chainID:chainID templateData:templateData];
}

- (void)setAccessToken{
    NSString *action = getNonceEndpoint;
    [[CVSDKRESTfulClient marketShared] getNonce:action completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        if (result[@"data"] && [result[@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = result[@"data"];
            CVSDKNonce *nonce = [[CVSDKNonce alloc] initWithObjectDict:data];
            [CVSDKUserDefault setXUserTime:[nonce time]];
            [CVSDKUserDefault setXUserNonce:[nonce nonce]];
            NSString *signedPersonalMessage = [[CVSDKBridgingWeb3 shared] signPersonalMessage:[nonce message]];
            [CVSDKUserDefault setXUserSignatureV2:signedPersonalMessage];
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}


- (void)getListItemOnMarket:(NSInteger )page pageSize:(NSInteger ) pageSize{
    NSString *action = [NSString stringWithFormat:getListItemOnMarketEndpoint, [ChainverseSDK shared].gameAddress, page,pageSize];
    NSLog(@"nampv_listnft %@",action);
    [[CVSDKRESTfulClient marketShared] getListItemOnMarket:action completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([CVSDKParseJson errorCode:responseObject] == 0){
            NSMutableArray<NFT> *nfts = [self handleDataModel:responseObject];
            [CVSDKCallbackToGame didGetListItemMarket:nfts];
        }else{
            [CVSDKCallbackToGame didError:ERROR_REQUEST_ITEM];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CVSDKCallbackToGame didError:ERROR_REQUEST_ITEM];
    }];
}


- (NSMutableArray<NFT> *)handleDataModel:(id)responseObject{
    CVSDKNFTResult *data = [[CVSDKNFTResult alloc] initWithDictionary:responseObject error:nil];
    NSMutableArray<NFT> *nftArr = [NSMutableArray<NFT> array] ;
    if([[data data] rows].count > 0){
        for(NFT *item in [[data data] rows]){
            Auction *aution = item.auctions.firstObject;
            InfoSell *infoSell = [[InfoSell alloc] init];
            infoSell.listing_id = aution.listing_id;
            infoSell.price = aution.price;
            infoSell.is_auction = aution.is_auction;
            infoSell.currency_info = aution.currency_info;
            item.infoSell = infoSell;
            [nftArr addObject:item];
        }
    }
    return nftArr;
}

- (NSMutableArray<NFT> *)handleDataModelMyAsset:(id)responseObject{
    CVSDKNFTData *data = [[CVSDKNFTData alloc] initWithDictionary:responseObject error:nil];
    NSMutableArray<NFT> *nftArr = [NSMutableArray<NFT> array] ;
    if([data data].count > 0){
        for(NFT *item in [data data]){
            Auction *aution = item.auctions.firstObject;
            InfoSell *infoSell = [[InfoSell alloc] init];
            infoSell.listing_id = aution.listing_id;
            infoSell.price = aution.price;
            infoSell.is_auction = aution.is_auction;
            infoSell.currency_info = aution.currency_info;
            item.infoSell = infoSell;
            [nftArr addObject:item];
        }
    }
    return nftArr;
    
}


- (void)getMyAsset{
    NSString *action = [NSString stringWithFormat:getMyAssetEndpoint, [ChainverseSDK shared].gameAddress];
    [[CVSDKRESTfulClient marketShared] getMyAsset:action completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([CVSDKParseJson errorCode:responseObject] == 0){
            //CVSDKNFTData *data = [[CVSDKNFTData alloc] initWithDictionary:responseObject error:nil];
            NSMutableArray<NFT> *nfts = [self handleDataModelMyAsset:responseObject];
            
            [CVSDKCallbackToGame didGetMyAssets:nfts];
        }else{
            [CVSDKCallbackToGame didError:ERROR_REQUEST_ITEM];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CVSDKCallbackToGame didError:ERROR_REQUEST_ITEM];
    }];
}


- (void)buyNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseSDK"]){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:currency forKey:@"currency"];
        [params setObject:[NSNumber numberWithInteger:listingId] forKey:@"listingId"];
        [params setObject:price forKey:@"price"];
        
        NSString *name = @"0 BNB";
        if([currency isEqualToString:@"0x0000000000000000000000000000000000000000"]){
            NSString *price = [params objectForKey:@"price"];
            name = [NSString stringWithFormat:@" - %@ BNB",price];
        }
        
        NSString *fee = [[CVSDKContractManager shared] feeBuyNFT:currency listingId:listingId price:price];
        CVSDKContractConfirmInput *input = [[CVSDKContractConfirmInput alloc] init];
        input.headTitle = @"Call Smart Contract";
        input.name = name;
        input.asset = @"";
        input.from = [CVSDKUserDefault getXUserAdress];
        input.granted_to = marketServiceAddress;
        input.contract = marketServiceAddress;
        input.fee = fee;
        input.function = @"buyNFT";
        input.params = params;
        [CVSDKContractConfirmScreen show:input];
    }else if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseApp"]){
        [[CVSDKContractManager shared] buyNFTWithChainverseApp:currency listingId:listingId price:price];
    }
    
}

- (NSString *)bidNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price{
    NSString *tx = [[CVSDKContractManager shared] bidNFT:currency listingId:listingId price:price];
    [CVSDKCallbackToGame didTransact:bidNFT tx:tx];
    return tx;
}



- (void)approveToken:(NSString *)token amount:(NSString *)amount{
    if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseSDK"]){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:token forKey:@"token"];
        [params setObject:amount forKey:@"amount"];
        NSString *fee = [[CVSDKContractManager shared] feeApproveToken:token spender:@"0x2ccA92F66BeA2A7fA2119B75F3e5CB698C252564" amount:amount];
        CVSDKContractConfirmInput *input = [[CVSDKContractConfirmInput alloc] init];
        input.headTitle = @"Approve";
        input.name = [NSString stringWithFormat:@"Give permission to access your %@?",[CVSDKUtils getCurrency:token]];
        input.asset = [CVSDKUtils getCurrency:token];
        input.from = [CVSDKUserDefault getXUserAdress];
        input.granted_to = marketServiceAddress;
        input.contract = token;
        input.fee = fee;
        input.function = @"approveToken";
        input.params = params;
        [CVSDKContractConfirmScreen show:input];
    }else if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseApp"]){
        [[CVSDKContractManager shared] approveTokenWithChainverseApp:token spender:@"0x2ccA92F66BeA2A7fA2119B75F3e5CB698C252564" amount:amount];
    }
    
}

- (void)sellNFT:(NSString *)NFT tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency{
    if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseSDK"]){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:NFT forKey:@"NFT"];
        [params setObject:[NSNumber numberWithInteger:tokenId] forKey:@"tokenId"];
        [params setObject:price forKey:@"price"];
        [params setObject:currency forKey:@"currency"];
        
        NSString *fee = [[CVSDKContractManager shared] feeSellNFT:NFT tokenId:tokenId price:price currency:currency];
        CVSDKContractConfirmInput *input = [[CVSDKContractConfirmInput alloc] init];
        input.headTitle = @"Call Smart Contract";
        input.name = @"0 BNB";
        input.asset = @"";
        input.from = [CVSDKUserDefault getXUserAdress];
        input.granted_to = marketServiceAddress;
        input.contract = marketServiceAddress;
        input.fee = fee;
        input.function = @"sellNFT";
        input.params = params;
        [CVSDKContractConfirmScreen show:input];
    }else{
        [[CVSDKContractManager shared] sellNFTWithChainverseApp:NFT tokenId:tokenId price:price currency:currency];
    }
    
}

- (void)approveNFT:(NSString *)nft tokenId:(NSInteger )tokenId{
    if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseSDK"]){
        [[ChainverseSDK shared] getNFT:nft tokenId:tokenId complete:^(NFT *item){
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:nft forKey:@"nft"];
            [params setObject:[NSNumber numberWithInteger:tokenId] forKey:@"tokenId"];
            NSString *fee = [[CVSDKContractManager shared] feeApproveNFT:nft tokenId:tokenId];
            CVSDKContractConfirmInput *input = [[CVSDKContractConfirmInput alloc] init];
            input.headTitle = @"Approve";
            input.name = item.name;
            input.asset = item.name;
            input.from = [CVSDKUserDefault getXUserAdress];
            input.granted_to = marketServiceAddress;
            input.contract = nft;
            input.fee = fee;
            input.function = @"approveNFT";
            input.params = params;
            [CVSDKContractConfirmScreen show:input];
        }];
    }else if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseApp"]){
        [[CVSDKContractManager shared] approveNFTWithChainverseApp:nft tokenId:tokenId];
    }
}

- (NSString *)approveNFTForGame:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSString *tx = [[CVSDKContractManager shared] approveNFTForGame:nft tokenId:tokenId];
    [CVSDKCallbackToGame didTransact:approveNFT tx:tx];
    return tx;
}

- (NSString *)approveNFTForService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSString *tx = [[CVSDKContractManager shared] approveNFTForService:service abi:abi nft:nft tokenId:tokenId];
    [CVSDKCallbackToGame didTransact:approveNFT tx:tx];
    return tx;
}

- (void)cancelSellNFT: (NSInteger )listingId{
    if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseSDK"]){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:[NSNumber numberWithInteger:listingId] forKey:@"listingId"];
        NSString *fee = [[CVSDKContractManager shared] feeCancelSellNFT:listingId];
        CVSDKContractConfirmInput *input = [[CVSDKContractConfirmInput alloc] init];
        input.headTitle = @"Call Smart Contract";
        input.name = @"0 BNB";
        input.asset = @"";
        input.from = [CVSDKUserDefault getXUserAdress];
        input.granted_to = marketServiceAddress;
        input.contract = marketServiceAddress;
        input.fee = fee;
        input.function = @"cancelSellNFT";
        input.params = params;
        [CVSDKContractConfirmScreen show:input];
    }else if([[CVSDKUserDefault getConnectWallet] isEqualToString:@"ChainverseApp"]){
        [[CVSDKContractManager shared] cancelSellNFTWithChainverseApp:listingId];
    }
}

- (void)getNFT:(NSString *)nft tokenId:(NSInteger )tokenId complete:(CVSDKGetNFTBlock) complete{
    [[CVSDKContractManager shared] getNFT:nft tokenId:tokenId complete:complete];
}

- (void)getDetailNFT:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSString *action = [NSString stringWithFormat:getDetailNFTEndpoint, nft, tokenId];
    [[CVSDKRESTfulClient marketShared] getDetailNFT:action completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([CVSDKParseJson errorCode:responseObject] == 0){
            NFT *nft = [self handleDataModelDetail:responseObject];
            [CVSDKCallbackToGame didGetDetailItem:nft];
        }else{
            [CVSDKCallbackToGame didError:ERROR_REQUEST_ITEM];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CVSDKCallbackToGame didError:ERROR_REQUEST_ITEM];
    }];
}

- (NFT *)handleDataModelDetail:(id)responseObject{
    CVSDKNFTDetail *data = [[CVSDKNFTDetail alloc] initWithDictionary:responseObject error:nil];
    Auction *aution = [data data].auctions.firstObject;
    InfoSell *infoSell = [[InfoSell alloc] init];
    infoSell.listing_id = aution.listing_id;
    infoSell.price = aution.price;
    infoSell.is_auction = aution.is_auction;
    
    infoSell.currency_info = aution.currency_info;
    [data data].infoSell = infoSell;
    return [data data];
}

- (void)publishNFT:(NSString *)nft tokenId:(NSInteger )tokenId complete:(CVSDKPublishNFTBlock) complete{
    NSString *action = [NSString stringWithFormat:publishNFTEndpoint, nft, tokenId];
    [[CVSDKRESTfulClient marketShared] publishNFT:action completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(TRUE);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (BOOL)isApproved:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSString *getApproved = [[CVSDKContractManager shared] isApproved:nft tokenId:tokenId];
    if([getApproved isEqualToString:marketServiceAddress]){
        return true;
    };
    return false;
}

- (BOOL)isApprovedForService:(NSString *)nft service:(NSString*)service tokenId:(NSInteger )tokenId{
    NSString *getApproved = [[CVSDKContractManager shared] isApproved:nft tokenId:tokenId];
    if([getApproved isEqualToString:service]){
        return true;
    };
    return false;
}

- (NSString *)isApproved:(NSString *)token owner:(NSString*)owner{
    return [[CVSDKContractManager shared] isApproved:token owner:owner spender:@"0x2ccA92F66BeA2A7fA2119B75F3e5CB698C252564"];
}

- (void)transferItem:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    [[ChainverseSDK shared] getNFT:nft tokenId:tokenId complete:^(NFT *item){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:to forKey:@"to"];
        [params setObject:nft forKey:@"nft"];
        [params setObject:[NSNumber numberWithInteger:tokenId] forKey:@"tokenId"];
        NSString *fee = [[CVSDKContractManager shared] feeTransferItem:to nft:nft tokenId:tokenId];
        CVSDKContractConfirmInput *input = [[CVSDKContractConfirmInput alloc] init];
        input.headTitle = @"Transfer";
        input.name = item.name;
        input.asset = item.name;
        input.from = [CVSDKUserDefault getXUserAdress];
        input.granted_to = to;
        input.contract = nft;
        input.fee = fee;
        input.function = @"transferItem";
        input.params = params;
        [CVSDKContractConfirmScreen show:input];
    }];
}

- (NSString *)withdrawNFT:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSString *tx =  [[CVSDKContractManager shared] withdrawNFT:nft tokenId:tokenId];
    [CVSDKCallbackToGame didTransact:withdrawItem tx:tx];
    return tx;
}

- (NSString *)moveItemToGame:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSString *tx = [[CVSDKContractManager shared] moveItemToGame:nft tokenId:tokenId];
    [CVSDKCallbackToGame didTransact:moveService tx:tx];
    return tx;
}

- (NSString *)moveItemToService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId{
    NSString *tx = [[CVSDKContractManager shared] moveItemToService:service abi:abi nft:nft tokenId:tokenId];
    [CVSDKCallbackToGame didTransact:moveService tx:tx];
    return tx;
}

- (BOOL) isAddress:(NSString *)address{
    return [[CVSDKBridgingWeb3 shared] isAddress:address];
}
@end
