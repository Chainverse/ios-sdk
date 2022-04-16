//
//  CVSDKNonce.h
//  Chainverse-SDK
//
//  Created by pham nam on 05/03/2022.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKNonce : CVSDKBaseObject
- (NSString*) message;
- (NSString*) nonce;
- (NSString*) time;
@end

NS_ASSUME_NONNULL_END
