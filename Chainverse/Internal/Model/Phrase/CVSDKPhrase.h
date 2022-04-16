//
//  CVSDKPhrase.h
//  Chainverse-SDK
//
//  Created by pham nam on 01/12/2021.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKPhrase : CVSDKBaseObject
- (NSString*) body;
- (NSNumber*) order;
- (NSNumber*) position;
- (NSString*) isShow;
@end

NS_ASSUME_NONNULL_END
