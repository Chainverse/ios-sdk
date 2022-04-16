//
//  CVSDKService.h
//  Chainverse-SDK
//
//  Created by pham nam on 08/03/2022.
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
