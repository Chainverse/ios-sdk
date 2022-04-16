//
//  ChainverseUser.h
//  Chainverse-SDK
//
//  Created by pham nam on 01/09/2021.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChainverseUser : CVSDKBaseObject
- (NSString*) address;
- (NSString*) signature;
@end

NS_ASSUME_NONNULL_END
