//
//  CVSDKRPCRequest.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "CVSDKBaseBlocks.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKRPCClient : AFHTTPSessionManager
+ (CVSDKRPCClient *) shared;

- (void)connect:(NSMutableArray*) params method:(NSString *)method completeBlock:(CVSDKRPCResponeBlock) complete;
+ (NSMutableArray *)createParams:( nullable NSMutableDictionary *)obj;
@end

NS_ASSUME_NONNULL_END
