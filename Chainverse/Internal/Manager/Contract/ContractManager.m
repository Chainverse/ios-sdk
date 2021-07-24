//
//  ContractManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import "ContractManager.h"
#import "CVSDKRPCClient.h"
#import "CVSDKBridging.h"
#import "CVSDKUtils.h"
#import <PromiseKit/PromiseKit.h>
#import "CVSDKConstant.h"
#import "CVSDKConvert.h"
#import "ChainverseSDK.h"
#import "Chainverse_SDK-Swift.h"
@implementation ContractManager
- (void)check:(CVSDKContractStatusBlock) complete{
    PMKJoin(@[[self isDeveloperContract],
              [self isGameContract],
              [self isGamePaused],
              [self isDeveloperPaused]
            ]).then(^(id responseObject) {
        return [self checkContract:responseObject complete:complete];
    }).catch(^(NSError *error){
        complete(false);
    });;

}
- (void) checkContract: (id) responseObject complete:(CVSDKContractStatusBlock) complete{
    NSLog(@"nampv_respone %@",responseObject);
    if([responseObject count] == 4){
        NSDictionary *gameContract = (NSDictionary *)[responseObject objectAtIndex:0];
        NSDictionary *devContract = (NSDictionary *)[responseObject objectAtIndex:1];
        NSDictionary *gamePaused = (NSDictionary *)[responseObject objectAtIndex:2];
        NSDictionary *devPaused = (NSDictionary *)[responseObject objectAtIndex:3];
        
        if ([gameContract objectForKey:@"result"]
            && [devContract objectForKey:@"result"]
            && [gamePaused objectForKey:@"result"]
            && [devPaused objectForKey:@"result"]) {
            if([CVSDKConvert hexToBool:gameContract[@"result"]]
               && [CVSDKConvert hexToBool:devContract[@"result"]]
               && [CVSDKConvert hexToBool:gamePaused[@"result"]]
               && ![CVSDKConvert hexToBool:devPaused[@"result"]]){
                complete(TRUE);
            }else{
                complete(FALSE);
            }
        }else{
            complete(FALSE);
        }
       
    }else{
        complete(FALSE);
    }
}

- (AnyPromise *)isDeveloperContract
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = [ChainverseSDK shared].developerAddress;
        obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isDeveloperContract()" params:[NSArray array]];
        
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}

- (AnyPromise *)isGameContract
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = [ChainverseSDK shared].gameAddress;
        obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isGameContract()" params:[NSArray array]];
        
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}

- (AnyPromise *)isGamePaused
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        W3Address *gameAddress = [[W3Address alloc] initWithString:[ChainverseSDK shared].gameAddress];
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = chainverseFactoryAddress;
        obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isGamePaused(address)" params:@[gameAddress]];
        
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}

- (AnyPromise *)isDeveloperPaused
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        W3Address *devAddress = [[W3Address alloc] initWithString:[ChainverseSDK shared].developerAddress];
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = chainverseFactoryAddress;
        obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isDeveloperPaused(address)" params:@[devAddress]];
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}


@end
