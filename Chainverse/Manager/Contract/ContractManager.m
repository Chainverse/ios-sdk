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
    NSMutableArray *params = [[NSMutableArray alloc] init];
    NSMutableDictionary *dt = [NSMutableDictionary dictionary];
       dt[@"developerAddress"] = self.developerAddress;
    //[params addObject:dt];
    
    NSLog(@"nampv_request1 %@",params);
    [[CVSDKRPCClient shared] connect:params method:@"eth_blockNumber" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            if(isCheck){
                [self checkGameContract:complete];
            }
            NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}

- (void)checkGameContract:(CVSDKContractStatusBlock) complete{
    NSMutableArray *params = [[NSMutableArray alloc] init];
    NSMutableDictionary *dt = [NSMutableDictionary dictionary];
       dt[@"gameAddress"] = self.gameAddress;
    //[params addObject:dt];
    
    NSLog(@"nampv_request1 %@",params);
    [[CVSDKRPCClient shared] connect:params method:@"eth_blockNumber" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
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
    NSMutableArray *params = [[NSMutableArray alloc] init];
    NSMutableDictionary *dt = [NSMutableDictionary dictionary];
       dt[@"gameAddress"] = self.gameAddress;
    //[params addObject:dt];
    
    NSLog(@"nampv_request1 %@",params);
    [[CVSDKRPCClient shared] connect:params method:@"eth_blockNumber" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
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
    NSMutableArray *params = [[NSMutableArray alloc] init];
    NSMutableDictionary *dt = [NSMutableDictionary dictionary];
       dt[@"gameAddress"] = self.gameAddress;
    //[params addObject:dt];
    
    NSLog(@"nampv_request1 %@",params);
    [[CVSDKRPCClient shared] connect:params method:@"eth_blockNumber" completeBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (!error) {
            BOOL isCheck = YES;
            complete(isCheck);
            NSLog(@"Reply JSON: %@", responseObject);
        }
    }];
}
@end
