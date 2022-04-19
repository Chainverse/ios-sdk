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
/*
 ChainverseSDK delegate
 */

@property (nonatomic, weak) id<ChainverseSDKCallback> delegate;

/*
 Config scheme để open ví
 */
@property(nonatomic, strong) NSString * scheme;

/*
 Config game contract address
 */
@property(nonatomic, strong) NSString * gameAddress;

/*
 Config developer contract address
 */
@property(nonatomic, strong) NSString * developerAddress;

/*
 @return The singleton instance of ChainverseSDK
 */
+ (ChainverseSDK *)shared;

/*
 Hàm init
 */
- (void)initialize;

/*
* setKeepConnect: Keep connect wallet
*/
- (void)setKeepConnect:(BOOL) isKeep;


/**
* logout: Logout
*/
- (void)logout;

/*
 handleOpenUrl: Hàm xử lý callback từ app ví
 Open URI-scheme for iOS 9 and above
 @param app app
 @param url url
 @param options options
 */
- (BOOL)handleOpenUrl:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

/*
 handleOpenUrl: Hàm xử lý callback từ app ví
 Open URI-scheme for iOS 13 and above
 @param scene scene
 @param URLContexts URLContexts
 */
- (void)handleOpenUrl:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts NS_AVAILABLE_IOS(13_0);


/*
 handleOpenUrl: Hàm xử lý callback từ app ví
 @param application application
 @param url url
 @param sourceApplication sourceApplication
 @param annotation annotation
 */

-(BOOL)handleOpenUrl:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation;

/*
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

/*
 showConnectWalletView: Hàm này sử dụng để hiển thị màn hình tạo, import ví
 */
- (void)showConnectWalletView;

/*
 showWalletInfoView: Hàm này sử dụng để hiển thị thông tin ví
 */
- (void)showWalletInfoView;

/*
 getBalance: Hàm này sử dụng để lấy số dư của native coin
 */
- (NSString *)getBalance;

/*
 getBalance: Hàm này sử dụng để lấy số dư của token
 */
- (NSString *)getBalance:(NSString *)contractAddress;

/*
 signMessage: Hàm này sử dụng để sign message
 @param NSString message
 */
- (void)signMessage:(NSString *)message;

- (void)signTransaction:(NSString *)nonce gasPrice:(NSString *)gasPrice gasLimit:(NSString *)gasLimit toAddress:(NSString *)toAddress amount:(NSString *)amount chainID:(NSString *)chainID templateData:(NSData *)templateData;

/*
 getListItemOnMarket: Hàm này sử dụng để lấy danh sách NFT đang được bán trên chợ
 @param NSInteger page
 @param NSInteger pageSize
 */
- (void)getListItemOnMarket:(NSInteger )page pageSize:(NSInteger ) pageSize;

/*
 getMyAsset: Hàm này sử dụng  để lấy danh sách NFT đang có của 1 địa chỉ ví
 */
- (void)getMyAsset;

/*
 buyNFT: Mua NFT trên chợ
 @param NSString currency
 @param NSInteger listingId
 @param NSString price
 */
- (void)buyNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;

/*
 bidNFT: Đấu giá NFT trên chợ
 @param NSString currency
 @param NSInteger listingId
 @param NSString price
 */
- (NSString *)bidNFT:(NSString *)currency listingId:(NSInteger )listingId price:(NSString *)price;

/*
 approveToken: Hàm này sử dụng để approve token cho một địa chỉ
 @param NSString token
 @param NSString amount
 */
- (NSString *)approveToken:(NSString *)token amount:(NSString *)amount;

/*
 sellNFT: Hàm này sử dụng để bán item lên chợ
 @param NSString NFT
 @param NSInteger tokenId
 @param NSString price
 @param NSString currency
 */
- (NSString *)sellNFT:(NSString *)NFT tokenId:(NSInteger )tokenId price:(NSString *)price currency:(NSString *)currency;

/*
 approveNFT: Hàm này sử dụng để approve NFT trước khi bán lên chợ
 @param NSString nft
 @param NSInteger tokenId
 */
- (NSString *)approveNFT:(NSString *)nft tokenId:(NSInteger )tokenId;

- (NSString *)approveNFTForGame:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)approveNFTForService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;

/*
 cancelSellNFT: Hàm này sử dụng để đừng bán NFT trên chợ
 @param NSInteger listingId
 */
- (NSString *)cancelSellNFT: (NSInteger )listingId;

/*
 getNFT: Hàm này sử dụng để lấy thông tin chi tiết của một NFT (dữ liệu onchain)
 @param NSString nft
 @param NSInteger tokenId
 */
- (void)getNFT:(NSString *)nft tokenId:(NSInteger )tokenId complete:(CVSDKGetNFTBlock) complete;

/*
 getDetailNFT: Hàm này sử dụng để lấy thông tin chi tiết của một NFT (dữ liệu offchain)
 @param NSString nft
 @param NSInteger tokenId
 */
- (void)getDetailNFT:(NSString *)nft tokenId:(NSInteger )tokenId;

/*
 publishNFT: Hàm này sử dụng để publish NFT lên chợ
 @param NSString nft
 @param NSInteger tokenId
 */
- (void)publishNFT:(NSString *)nft tokenId:(NSInteger )tokenId complete:(CVSDKPublishNFTBlock) complete;

/*
 isApproved(NFT): Hàm này sử dụng để kiểm tra NFT đã được approve hay là chưa
 @param NSString nft
 @param NSInteger tokenId
 */
- (BOOL)isApproved:(NSString *)nft tokenId:(NSInteger )tokenId;

/*
 isApproved(Token): Hàm này sử dụng để kiểm tra token số lượng token approve vào chợ
 @param NSString token
 @param NSString owner
 */
- (NSString *)isApproved:(NSString *)token owner:(NSString* )owner;

- (BOOL)isApprovedForService:(NSString *)nft service:(NSString*)service tokenId:(NSInteger )tokenId;

/*
 transferItem: Hàm này sử dụng để chuyển NFT sang địa chỉ khác
 @param NSString to
 @param NSString nft
 @param NSInteger tokenId
 */
- (NSString *)transferItem:(NSString *)to nft:(NSString *)nft tokenId:(NSInteger )tokenId;

- (NSString *)withdrawNFT:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)moveItemToGame:(NSString *)nft tokenId:(NSInteger )tokenId;
- (NSString *)moveItemToService:(NSString*)service abi:(NSString *)abi nft:(NSString *)nft tokenId:(NSInteger )tokenId;
- (BOOL) isAddress:(NSString *)address;
@end

NS_ASSUME_NONNULL_END
