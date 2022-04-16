//
//  CVSDKChainverseResult.h
//  Chainverse-SDK
//
//  Created by pham nam on 16/08/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKChainverseAppResult : NSObject
+ (NSString *)getUserAddress:(NSURL *)url;
+ (NSString *)getSignature0: (NSURL *)url;
+ (NSString *)getSignature1: (NSURL *)url;
+ (NSString *)getSignature: (NSURL *)url;
+ (NSString *)getTime: (NSURL *)url;
+ (NSString *)getNonce: (NSURL *)url;
+ (NSString *)getAction: (NSURL *)url;
@end

NS_ASSUME_NONNULL_END
