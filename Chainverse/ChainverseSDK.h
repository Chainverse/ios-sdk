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
* return list support wallet
*/
- (void)getItems;

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
 connectWithTrust: Connect with Trust Wallet
 */
- (void)connectWithTrust;

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

@end

NS_ASSUME_NONNULL_END
