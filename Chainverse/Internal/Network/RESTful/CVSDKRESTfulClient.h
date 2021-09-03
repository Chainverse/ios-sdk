//
//  CVSDKRESTfulClient.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/06/2021.
//

#import "AFHTTPSessionManager.h"
#import "CVSDKBaseBlocks.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKRESTfulClient : AFHTTPSessionManager
+ (CVSDKRESTfulClient *) shared;
- (void)get:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)post:(NSString *)param completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)connect:(NSMutableArray*) params method:(NSString *)method completeBlock:(CVSDKRPCResponeBlock) complete;
@end

NS_ASSUME_NONNULL_END
