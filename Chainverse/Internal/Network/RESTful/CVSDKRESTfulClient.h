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
+ (CVSDKRESTfulClient *) marketShared;
- (void)get:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)post:(NSString *)param completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)connect:(NSMutableArray*) params method:(NSString *)method completeBlock:(CVSDKRPCResponeBlock) complete;
- (void)getNonce:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)getListItemOnMarket:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)getServiceByGame:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)getMyAsset:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)publishNFT:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)getDetailNFT:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
- (void)getTokenUri:(NSString *)action completeBlock:(CVSDKRESTfulSuccess) complete failure:(CVSDKRESTfulFailure) failure;
@end

NS_ASSUME_NONNULL_END
