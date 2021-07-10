//
//  ContractManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//

#import "ContractManager.h"
#import "CVSDKRPCClient.h"
@implementation ContractManager
- (void)check:(CVSDKContractStatusBlock) complete{
    [self checkDeveloperContract:complete];
}

- (void)checkDeveloperContract:(CVSDKContractStatusBlock) complete{
    NSMutableDictionary *obj = [NSMutableDictionary dictionary];
    obj[@"to"] = @"0x690FDdc2a98050f924Bd7Ec5900f2D2F49b6aEC7";
    obj[@"data"] = @"0x61f718bb";
    
    [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            if(isCheck){
                [self checkGameContract:complete];
            }
            //NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}

- (void)checkGameContract:(CVSDKContractStatusBlock) complete{
    NSMutableDictionary *obj = [NSMutableDictionary dictionary];
    obj[@"to"] = @"0x3F57BF31E55de54306543863E079aD234f477b88";
    obj[@"data"] = @"0x244675aa";
    
    [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            if(isCheck){
                [self checkGamePaused:complete];
            }
            //NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}

- (void)checkGamePaused:(CVSDKContractStatusBlock) complete{
    NSMutableDictionary *obj = [NSMutableDictionary dictionary];
    obj[@"to"] = @"0xd786Db6012d7A542e7531068b0f987Da6414C54B";
    obj[@"data"] = @"0x44e097aa0000000000000000000000003f57bf31e55de54306543863e079ad234f477b88";
    
    [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            if(isCheck){
                [self checkDeveloperPaused:complete];
            }
            //NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}

- (void)checkDeveloperPaused:(CVSDKContractStatusBlock) complete{
    NSMutableDictionary *obj = [NSMutableDictionary dictionary];
    obj[@"to"] = @"0xd786Db6012d7A542e7531068b0f987Da6414C54B";
    obj[@"data"] = @"0x1298d00d000000000000000000000000690fddc2a98050f924bd7ec5900f2d2f49b6aec7";
    [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_call" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            complete(isCheck);
            NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}
@end
