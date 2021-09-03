//
//  ContractManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import "CVSDKContractManager.h"
#import "CVSDKRPCClient.h"
#import "CVSDKBridging.h"
#import "CVSDKUtils.h"
#import <PromiseKit/PromiseKit.h>
#import "CVSDKConstant.h"
#import "CVSDKConvert.h"
#import "CVSDKCallbackToGame.h"
#import "ChainverseSDKError.h"
#import "ChainverseSDK.h"
@implementation CVSDKContractManager
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
               && ![CVSDKConvert hexToBool:gamePaused[@"result"]]
               && ![CVSDKConvert hexToBool:devPaused[@"result"]]){
                complete(TRUE);
            }else{
                complete(FALSE);
            }
           
        }else{
            complete(FALSE);
        }
        
        
        //Callback Error
        if(![gameContract objectForKey:@"result"] || ![CVSDKConvert hexToBool:gameContract[@"result"]]){
            [CVSDKCallbackToGame didError:ERROR_GAME_ADDRESS];
        }
        
        if(![devContract objectForKey:@"result"] || ![CVSDKConvert hexToBool:devContract[@"result"]]){
            [CVSDKCallbackToGame didError:ERROR_DEVELOPER_ADDRESS];
        }
        
        if(![gamePaused objectForKey:@"result"] || [CVSDKConvert hexToBool:gamePaused[@"result"]]){
            [CVSDKCallbackToGame didError:ERROR_GAME_PAUSE];
        }
        
        if(![devPaused objectForKey:@"result"] || [CVSDKConvert hexToBool:devPaused[@"result"]]){
            [CVSDKCallbackToGame didError:ERROR_DEVELOPER_PAUSE];
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
        obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isDeveloperContract()" address:@""];
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
        obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isGameContract()" address:@""];
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
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = chainverseFactoryAddress;
        obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isGamePaused(address)" address:[ChainverseSDK shared].gameAddress];
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
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = chainverseFactoryAddress;
        obj[@"data"] = [CVSDKBridging EthFunctionEncode:@"isDeveloperPaused(address)" address:[ChainverseSDK shared].developerAddress];
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}


@end
