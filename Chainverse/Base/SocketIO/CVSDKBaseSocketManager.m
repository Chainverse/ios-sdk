//
//  CVSDKSocketIOManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 16/06/2021.
//

#import "CVSDKBaseSocketManager.h"

@implementation CVSDKBaseSocketManager
- (instancetype) init{
    if ((self = [super init])) {
        NSURL* url = [[NSURL alloc] initWithString:@"http://192.168.101.144:3000"];
        self.manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @YES, @"compress": @YES}];
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
}@end
