//
//  ChainverseSDKCallback.h
//  Chainverse-SDK
//
//  Created by pham nam on 14/06/2021.
//

#import <Foundation/Foundation.h>
#import "ChainverseItem.h"
@protocol ChainverseSDKCallback <NSObject>

@required
- (void)didInitSDKSuccess;
- (void)didError:(int)error;
- (void)didConnectSuccess:(NSString *) address;
- (void)didLogout:(NSString *) address;
- (void)didGetItems:(NSMutableArray *) items;
- (void)didItemUpdate:(ChainverseItem *)item type:(int)type;
@end


