//
//  ContractManager.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import <Foundation/Foundation.h>
#import "CVSDKBaseBlocks.h"
#import "CVSDKBaseWeb3.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContractManager : NSObject
@property (nonatomic, nonatomic) CVSDKBaseWeb3 *web3;
@property(nonatomic, strong) NSString * developerAddress;
@property(nonatomic, strong) NSString * gameAddress;
- (void)check:(CVSDKContractStatusBlock) complete;
@end

NS_ASSUME_NONNULL_END
