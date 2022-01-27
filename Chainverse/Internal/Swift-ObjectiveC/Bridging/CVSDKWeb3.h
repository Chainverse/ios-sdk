//
//  CVSDKWeb3.h
//  Chainverse-SDK
//
//  Created by pham nam on 08/12/2021.
//

#import <Foundation/Foundation.h>
#import "Chainverse_SDK-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWeb3 : NSObject
//+ (CVSDKWeb3 *) shared;
+ (NSString *)signMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
