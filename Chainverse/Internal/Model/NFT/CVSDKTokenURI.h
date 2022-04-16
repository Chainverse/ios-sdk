//
//  ChainverseItemMarket.h
//  Chainverse-SDK
//
//  Created by pham nam on 07/03/2022.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKTokenURI : CVSDKBaseObject
- (NSString*) name;
- (NSString*) attributes;
- (NSString*) descriptionnft;
- (NSString*) image;

@end

NS_ASSUME_NONNULL_END
