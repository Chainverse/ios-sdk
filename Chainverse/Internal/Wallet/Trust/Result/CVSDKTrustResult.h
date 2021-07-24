//
//  CVSDKTrustResult.h
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKTrustResult : NSObject
+ (NSString *)getUserAddress:(NSURL *)url;
+ (int)getAction:(NSURL *) url;
+ (NSString *)getSignature: (NSURL *)url;
@end

NS_ASSUME_NONNULL_END
