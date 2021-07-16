//
//  ContractManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import "ContractManager.h"
#import "CVSDKRPCClient.h"
#import "Chainverse_SDK-Swift.h"
#import "CVSDKUtils.h"
#import <PromiseKit/PromiseKit.h>
@implementation ContractManager
- (void)check:(CVSDKContractStatusBlock) complete{
    PMKJoin(@[[self isDeveloperContractPromise],
              [self isGameContractPromise],
              [self isGamePausedPromise],
              [self isDeveloperPausedPromise]
            ]).then(^(id responseObject) {
        return [self checkContract:responseObject complete:complete];
    }).catch(^(NSError* error){
    
    });

}
- (void) checkContract: (id) responseObject complete:(CVSDKContractStatusBlock) complete{
    
    if([responseObject count] > 0){
        NSDictionary *resultGameContract = (NSDictionary *)responseObject[0];
        NSLog(@"Reply1 JSON: %@", resultGameContract[@"result"]);
        
        NSDictionary *resultDevContract = (NSDictionary *)responseObject[1];
        NSLog(@"Reply2 JSON: %@", resultDevContract[@"result"]);
        
        
        NSDictionary *resultGamePaused = (NSDictionary *)responseObject[2];
        NSLog(@"Reply3 JSON: %@", resultGamePaused[@"result"]);
        
        NSDictionary *resultDevPaused = (NSDictionary *)responseObject[3];
        NSLog(@"Reply4 JSON: %@", resultDevPaused[@"result"]);
        
        int isGameContract = [CVSDKUtils convertHexToDecimal:resultGameContract[@"result"]];
        
        int isDevContract = [CVSDKUtils convertHexToDecimal:resultDevContract[@"result"]];
        
        int isGamePaused = [CVSDKUtils convertHexToDecimal:resultGamePaused[@"result"]];
        
        int isDevPaused = [CVSDKUtils convertHexToDecimal:resultDevPaused[@"result"]];
        
        
        if(isGameContract == 1 && isDevContract == 1 && isGamePaused == 1 && isDevPaused == 1){
            complete(TRUE);
        }
    }
    
    
}

- (AnyPromise *)isDeveloperContractPromise
{
    
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        ObjcSolidityFunction *function = [[ObjcSolidityFunction alloc] init];
        NSString *encode = [function encode:@"isDeveloperContract()" :[NSArray array]];
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = @"0x690FDdc2a98050f924Bd7Ec5900f2D2F49b6aEC7";
        obj[@"data"] = encode;
        
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}

- (AnyPromise *)isGameContractPromise
{
    
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        ObjcSolidityFunction *function = [[ObjcSolidityFunction alloc] init];
        NSString *encode = [function encode:@"isGameContract()" :[NSArray array]];
        
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = @"0x3F57BF31E55de54306543863E079aD234f477b88";
        obj[@"data"] = encode;
        
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}

- (AnyPromise *)isGamePausedPromise
{
    
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        W3Address *gameContractAddress = [[W3Address alloc] initWithString:@"0x3F57BF31E55de54306543863E079aD234f477b88"];
        
        ObjcSolidityFunction *function = [[ObjcSolidityFunction alloc] init];
        NSString *encode = [function encode:@"isGamePaused(address)" :@[gameContractAddress]];

        
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = @"0xd786Db6012d7A542e7531068b0f987Da6414C54B";
        obj[@"data"] = encode;
        
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}

- (AnyPromise *)isDeveloperPausedPromise
{
    
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve){
        W3Address *developerContractAddress = [[W3Address alloc] initWithString:@"0x3F57BF31E55de54306543863E079aD234f477b88"];
        
        ObjcSolidityFunction *function = [[ObjcSolidityFunction alloc] init];
        NSString *encode = [function encode:@"isDeveloperPaused(address)" :@[developerContractAddress]];
        
        NSLog(@"nampv_hic %@",encode);
        
        
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        obj[@"to"] = @"0xd786Db6012d7A542e7531068b0f987Da6414C54B";
        obj[@"data"] = encode;
        [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            if (!error) {
                resolve(responseObject);
            }
        }];
        
    }];
}


@end
