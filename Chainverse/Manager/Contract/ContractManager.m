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
    //obj[@"developerAddress"] = self.developerAddress;
    [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_blockNumber" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            if(isCheck){
                //[self checkGameContract:complete];
            }
            NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}

- (void)checkGameContract:(CVSDKContractStatusBlock) complete{
    NSMutableDictionary *obj = [NSMutableDictionary dictionary];
    obj[@"gameAddress"] = self.gameAddress;
    
    [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_blockNumber" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            if(isCheck){
                [self checkGamePaused:complete];
            }
            NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}

- (void)checkGamePaused:(CVSDKContractStatusBlock) complete{
    NSMutableDictionary *obj = [NSMutableDictionary dictionary];
    obj[@"gameAddress"] = self.gameAddress;
    
    [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_blockNumber" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            if(isCheck){
                [self checkDeveloperPaused:complete];
            }
            NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}

- (void)checkDeveloperPaused:(CVSDKContractStatusBlock) complete{
    NSMutableDictionary *obj = [NSMutableDictionary dictionary];
    obj[@"gameAddress"] = self.gameAddress;
    [[CVSDKRPCClient shared] connect:[CVSDKRPCClient createParams:obj] method:@"eth_blockNumber" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            complete(isCheck);
            NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}
@end
