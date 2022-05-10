//
//  CVSDKServiceGame.h
//  Chainverse-SDK
//
//  Created by pham nam on 10/05/2022.
//

#import <Chainverse/Chainverse.h>

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
