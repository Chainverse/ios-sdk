//
//  CVSDKService.h
//  Chainverse-SDK
//
//  Created by pham nam on 10/05/2022.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKService : CVSDKBaseObject
- (NSString*) name;
- (NSString*) type;
- (NSString*) version;
- (NSString*) address;
- (NSString*) abi;

@end

NS_ASSUME_NONNULL_END
