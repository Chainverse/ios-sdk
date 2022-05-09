//
//  CVSDKParseJson.h
//  Chainverse-SDK
//
//  Created by pham nam on 28/07/2021.
//

#import <Foundation/Foundation.h>
#import "ChainverseItem.h"
#import "CVSDKTokenURI.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKParseJson : NSObject
+ (int) errorCode:(id)responseObject;
+ (NSMutableArray *) parseItems:(id)responseObject;
+ (ChainverseItem *) parseItem:(NSArray*) data;
+ (CVSDKTokenURI *) parseTokenUri:(id)responseObject;
+ (NSArray *)parseRPC:(NSString *)rpcs;
@end

NS_ASSUME_NONNULL_END
