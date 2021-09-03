//
//  CVSDKParseJson.h
//  Chainverse-SDK
//
//  Created by pham nam on 28/07/2021.
//

#import <Foundation/Foundation.h>
#import "ChainverseItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKParseJson : NSObject
+ (int) errorCode:(id)responseObject;
+ (NSMutableArray *) parseItems:(id)responseObject;
+ (ChainverseItem *) parseItem:(NSArray*) data;
@end

NS_ASSUME_NONNULL_END
