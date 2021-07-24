//
//  CVSDKItem.h
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKItem : NSObject
- (NSInteger*) itemId;
- (NSInteger*) categoryId;
- (NSString*) gameAddress;
- (NSString*) attributes;
@end

NS_ASSUME_NONNULL_END
