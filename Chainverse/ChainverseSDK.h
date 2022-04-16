//
//  ChainverseSDK.h
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChainverseSDKCallback.h"
#import "ChainverseUser.h"
#import "CVSDKBaseBlocks.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : int {
    TRANSFER_ITEM_TO_USER = 1,
    TRANSFER_ITEM_FROM_USER = 2
} ChainverseTransferItemType;

@interface ChainverseSDK : NSObject
@property (nonatomic) BOOL isKeepConnect;
/**
 ChainverseSDK delegate
 */

@property (nonatomic, weak) id<ChainverseSDKCallback> delegate;

/**
 Config scheme để open ví
 */
@property(nonatomic, strong) NSString * scheme;

/**
 Config game contract address
 */
@property(nonatomic, strong) NSString * gameAddress;

/**
 Config developer contract address
 */
@property(nonatomic, strong) NSString * developerAddress;

/**
 @return The singleton instance of ChainverseSDK
 */
+ (ChainverseSDK *)shared;

/**
 Hàm init
 */
- (void)initialize;

/**
* setKeepConnect: Keep connect wallet
*/
- (void)setKeepConnect:(BOOL) isKeep;


/**
* logout: Logout
*/
- (void)logout;

/**
 handleOpenUrl: Hàm xử lý callback từ app ví
 Open URI-scheme for iOS 9 and above
 @param app app
 @param url url
 @param options options
 */
- (BOOL)handleOpenUrl:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

/**
 handleOpenUrl: Hàm xử lý callback từ app ví
 Open URI-scheme for iOS 13 and above
 @param scene scene
 @param URLContexts URLContexts
 */
- (void)handleOpenUrl:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts NS_AVAILABLE_IOS(13_0);


/**
 handleOpenUrl: Hàm xử lý callback từ app ví
 @param application application
 @param url url
 @param sourceApplication sourceApplication
 @param annotation annotation
 */

-(BOOL)handleOpenUrl:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation;

/**
 Return SDK Version
 */
- (NSString *)getVersion;

/**
 showConnectView: Show screen choose wallet
 */
- (void)showConnectView;

/**
 connectWithChainverse: Connect with Chainverse
 */
- (void)connectWithChainverse;

/**
 * isUserConnected: return status connected or no connected
 */
- (BOOL)isUserConnected;

/**
getUserInfo: Return user info
*/
- (ChainverseUser *) getUser;

- (void)testPurchase;

- (void)showConnectWalletView;

- (void)showWalletInfoView;

- (NSString *)getBalance;

- (NSString *)getBalance:(NSString *)contractAddress;

- (void)signMessage:(NSString *)message;

- (void)signTransaction:(NSString *)nonce gasPrice:(NSString *)gasPrice gasLimit:(NSString *)gasLimit toAddress:(NSString *)toAddress amount:(NSString *)amount chainID:(NSString *)chainID templateData:(NSData *)templateData;

- (void)getListItemOnMarket;
- (void)getMyAsset;
- (void)buyNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;
- (NSString *)bidNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;
- (NSString *)approveToken:(NSString *)token amount:(NSString *)amount;
- (NSString *)sellNFT:(NSString *)NFT tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency;
- (NSString *)approveNFT:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)approveNFTForGame:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)approveNFTForService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)cancelSellNFT: (NSInteger )listingId;
- (void)getNFT:(NSString *)nft tokenId:(NSInteger )tokenId complete:(CVSDKGetNFTBlock) complete;
- (void)getDetailNFT:(NSString *)nft tokenId:(NSInteger )tokenId;
- (void)publishNFT:(NSString *)nft tokenId:(NSInteger )tokenId complete:(CVSDKPublishNFTBlock) complete;
- (BOOL)isApproved:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)isApproved:(NSString *)token owner:(NSString* )owner spender:(NSString *)spender;
- (BOOL)isApprovedForService:(NSString *)nft service:(NSString*)service tokenId:(NSInteger )tokenId;
- (NSString *)transferItem:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)withdrawNFT:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)moveItemToGame:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)moveItemToService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (BOOL) isAddress:(NSString *)address;
@end

NS_ASSUME_NONNULL_END
