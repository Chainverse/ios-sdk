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
- (void)get:(NSString *)param completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)post:(NSString *)param completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;;
@end

NS_ASSUME_NONNULL_END
