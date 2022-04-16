//
//  CVSDKServiceGame.m
//  Chainverse-SDK
//
//  Created by pham nam on 08/03/2022.
//

#import "CVSDKServiceGame.h"
#import "CVSDKParseJson.h"
@implementation CVSDKServiceGame
- (NSString*) name{
    return [self.objectDict objectForKey:@"name"];
}
- (NSString*) address{
    return [self.objectDict objectForKey:@"address"];
}

- (NSDictionary *)network_info {
    return [self.objectDict objectForKey:@"network_info"];
}

- (NSString*)  networkChain_id{
    return [self.network_info objectForKey:@"chain_id"];
}
- (NSString *) networkName{
    return [self.network_info objectForKey:@"name"];
}
- (NSString *) network{
    return [self.network_info objectForKey:@"network"];
}
- (NSArray *) rpcs{
    //return [self.network_info objectForKey:@"rpcs"];
    return [CVSDKParseJson parseRPC:[self.network_info objectForKey:@"rpcs"]];
}

- (NSMutableArray *)services{
    return [CVSDKParseJson parseServices:[self.objectDict objectForKey:@"services"]];
}
@end
