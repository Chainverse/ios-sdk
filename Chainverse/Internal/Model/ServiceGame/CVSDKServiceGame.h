//
//  CVSDKServiceGame.h
//  Chainverse-SDK
//
//  Created by pham nam on 08/03/2022.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKServiceGame : CVSDKBaseObject
- (NSString*) name;
- (NSString*) address;
- (NSDictionary *)network_info;
- (NSString *)  networkChain_id;
- (NSString *) networkName;
- (NSString *) network;
- (NSArray *) rpcs;
- (NSMutableArray *)services;
@end

NS_ASSUME_NONNULL_END
