//
//  ChainverseSDK.h
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChainverseSDKCallback.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChainverseSDK : NSObject

/**
 ChainverseSDK delegate
 */

@property (nonatomic, weak) id<ChainverseSDKCallback> delegate;

/**
 Config scheme
 */
@property(nonatomic, strong) NSString * scheme;

@property(nonatomic, strong) NSString * gameAddress;

@property(nonatomic, strong) NSString * developerAddress;

/**
 @return The singleton instance of ChainverseSDK
 */
+ (ChainverseSDK *)shared;

/**
 Hàm init
 */
- (void)start;

/**
 Open URI-scheme for iOS 9 and above
 @param app app
 @param url url
 @param options options
 */
- (BOOL)handleOpenUrl:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

/**
 Open URI-scheme for iOS 13 and above
 */
- (void)handleOpenUrl:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts NS_AVAILABLE_IOS(13_0);

/**
 Return SDK Version
 */
- (NSString *)getVersion;

- (void)chooseWL;

- (void)connectTrust;

/**
 transferTrust.
 @param asset asset
 @param to to
 @param amount amount
 @param feePrice The feePrice
 @param feeLimit The freeLimit
 */
- (void)transferTrust:(NSString *)asset
                   to:(NSString *)to
               amount:(NSString *)amount
             feePrice:(NSString *)feePrice
             feeLimit:(NSString *)feeLimit;
@end

NS_ASSUME_NONNULL_END
