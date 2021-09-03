//
//  CVSDKChainverseResult.h
//  Chainverse-SDK
//
//  Created by pham nam on 16/08/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKChainverseResult : NSObject
+ (NSString *)getUserAddress:(NSURL *)url;
+ (NSString *)getSignature: (NSURL *)url;
@end

NS_ASSUME_NONNULL_END
