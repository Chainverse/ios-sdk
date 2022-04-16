//
//  CVSDKChainverseConnect.h
//  Chainverse-SDK
//
//  Created by pham nam on 16/08/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKChainverseApp : NSObject
@property (nonatomic, strong) NSString *data;
+ (void)connect;
+ (void)signMessage:(NSString *)message;
+ (void)sendTransaction:(NSString *)action to:(NSString *)to data:(NSString *)data value:(NSString *)value gasLimit:(NSString *)gasLimit gasPrice:(NSString *)gasPrice nonce:(NSString *)nonce;
@end

NS_ASSUME_NONNULL_END
