//
//  CVSDKSocketIOManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 16/06/2021.
//

#import "CVSDKBaseSocketIO.h"
#import "CVSDKConstant.h"
#import "CVSDKUserDefault.h"
#import "ChainverseSDK.h"
@implementation CVSDKBaseSocketIO
- (instancetype) init{
    if ((self = [super init])) {
        NSDictionary *dic =@{
             @"log": @YES,
             @"secure": @YES,
             @"forcePolling": @YES,
             @"forceWebsockets": @YES,
             @"connectParams" : @{@"EIO" : @"3"},
             @"forceNew": @YES,
             @"extraHeaders": @{@"x-type": @"SDK",
                                @"x-user-address": [CVSDKUserDefault getXUserAdress],
                                @"x-signature": [CVSDKUserDefault getXUserSignature],
                                @"x-game-address": [ChainverseSDK shared].gameAddress,
                                @"x-signature-ethers" : @"false"
             }
            
            };
                        
        NSURL* url = [[NSURL alloc] initWithString:urlSocketIO];
        self.manager = [[SocketManager alloc] initWithSocketURL:url config:dic];
    }
    return self;
}

- (void)connect{
    [[self.manager defaultSocket] connect];
}

- (void)disconnect{
    [[self.manager defaultSocket] disconnect];
}

- (NSUUID * _Nonnull)on:(NSString * _Nonnull)event callback:(void (^ _Nonnull)(NSArray * _Nonnull, SocketAckEmitter * _Nonnull))callback{
    return [[self.manager defaultSocket] on:event callback:callback];
}


- (void)emit:(NSString * _Nonnull)event with:(NSArray * _Nonnull)items{
    [[self.manager defaultSocket] emit:event with:items];
}
@end
