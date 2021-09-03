//
//  CVSDKSocketIOManager.h
//  Chainverse-SDK
//
//  Created by pham nam on 16/06/2021.
//

#import <Foundation/Foundation.h>
@import SocketIO;
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKBaseSocketIO : NSObject
@property (nonatomic, nonatomic) SocketManager* manager;
- (instancetype)init;
- (void)connect;
- (void)disconnect;
- (void)emit:(NSString * _Nonnull)event with:(NSArray * _Nonnull)items;
- (NSUUID * _Nonnull)on:(NSString * _Nonnull)event callback:(void (^ _Nonnull)(NSArray * _Nonnull, SocketAckEmitter * _Nonnull))callback;
@end

NS_ASSUME_NONNULL_END
