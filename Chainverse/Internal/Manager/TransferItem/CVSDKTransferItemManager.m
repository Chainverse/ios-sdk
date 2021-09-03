//
//  CVSDKTransferItemManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 25/08/2021.
//

#import "CVSDKTransferItemManager.h"
#import "CVSDKBaseSocketIO.h"
#import "CVSDKDefine.h"
@interface CVSDKTransferItemManager(){
   
}
@property (nonatomic, nonatomic) CVSDKBaseSocketIO *socketIO;
@end

@implementation CVSDKTransferItemManager
+ (CVSDKTransferItemManager *)shared{
    static CVSDKTransferItemManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)on:(CVSDKTransferItemListen) listener{
    self.socketIO = [[CVSDKBaseSocketIO alloc] init];
    
    [self.socketIO on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"chainverse_socket_connect");
        listener(EVENT_CONNECT,data);
    }];
    
   
    [self.socketIO on:@"transfer_item_to_user" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"chainverse_socket_transfer_item_to_user");
        listener(EVENT_TRANSFER_ITEM_TO_USER,data);
    }];
    
    [self.socketIO on:@"transfer_item_from_user" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"chainverse_socket_transfer_item_from_user");
        listener(EVENT_TRANSFER_ITEM_FROM_USER,data);
    }];

    [self.socketIO on:@"error" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"chainverse_socket_error");
        listener(EVENT_ERROR,data);
    }];
        
    
}
- (void)connect{
    [self.socketIO connect];
}
@end
