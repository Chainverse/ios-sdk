//
//  ChainverseItem.h
//  Chainverse-SDK
//
//  Created by pham nam on 29/07/2021.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChainverseItem : CVSDKBaseObject
- (NSString*) item_id;
- (NSString*) category_id;
- (NSString*) game_address;
- (NSString*) attributes;

@end

NS_ASSUME_NONNULL_END
