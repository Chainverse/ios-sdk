//
//  CVSDKRESTfulClientEndpoint.h
//  Chainverse-SDK
//
//  Created by pham nam on 05/03/2022.
//

#ifndef CVSDKRESTfulClientEndpoint_h
#define CVSDKRESTfulClientEndpoint_h
static NSString *getListItemOnMarketEndpoint = @"/v1/sdk/market/%@/items";
static NSString *getMyAssetEndpoint = @"/v1/sdk/user/%@/items";
static NSString *getServiceByGameEndpoint = @"/v1/sdk/game/%@";
static NSString *getNonceEndpoint = @"/v1/user/nonce";
static NSString *publishNFTEndpoint = @"/v1/user/item/publish/%@/%li";
static NSString *getDetailNFTEndpoint = @"/v1/sdk/market/item/%@/%li";
#endif
