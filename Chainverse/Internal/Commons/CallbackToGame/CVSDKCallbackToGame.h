//
//  CVSDKCallbackToGame.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/07/2021.
//

#import <Foundation/Foundation.h>
#import "ChainverseItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKCallbackToGame : NSObject
+ (void)didConnectSuccess:(NSString *)address;
+ (void)didLogout:(NSString *)address;
+ (void)didInitSDKSuccess;
+ (void)didError:(int) error;
+ (void)didGetItems:(NSMutableArray *)items;
+ (void)didItemUpdate:(ChainverseItem *)item type:(int)type;
@end

NS_ASSUME_NONNULL_END
