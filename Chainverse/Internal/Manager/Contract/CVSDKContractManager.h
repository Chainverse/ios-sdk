//
//  ContractManager.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseBlocks.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKContractManager : NSObject
- (void)check:(CVSDKContractStatusBlock) complete;
@end

NS_ASSUME_NONNULL_END
