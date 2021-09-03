//
//  CVSDKTransferItemManager.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/08/2021.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseBlocks.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKTransferItemManager : NSObject
+ (CVSDKTransferItemManager *) shared;
- (void)on:(CVSDKTransferItemListen) listener;
- (void)connect;
@end

NS_ASSUME_NONNULL_END
