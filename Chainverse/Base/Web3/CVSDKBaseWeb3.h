//
//  CVSDKBaseWeb3.h
//  Chainverse-SDK
//
//  Created by pham nam on 15/07/2021.
//

#import <Foundation/Foundation.h>
#import "Chainverse_SDK-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKBaseWeb3 : NSObject
- (void)initWeb3;
- (W3Address *) contract : (NSString *)address;
@end

NS_ASSUME_NONNULL_END
