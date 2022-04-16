//
//  CVSDKParseJson.m
//  Chainverse-SDK
//
//  Created by pham nam on 28/07/2021.
//

#import "CVSDKParseJson.h"
#import "ChainverseItem.h"
#import "CVSDKTokenURI.h"
#import "CVSDKService.h"
@implementation CVSDKParseJson
+ (int) errorCode:(id)responseObject{
    NSDictionary *result = (NSDictionary *) responseObject;
    return [result[@"error_code"] intValue];
}
+ (NSMutableArray *) parseItems:(id)responseObject{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSDictionary *result = (NSDictionary *) responseObject;
    if([result[@"error_code"] intValue] == 0){
        NSArray *dataItems = (NSArray *) result[@"items"];
        if([dataItems count] > 0){
            for(NSDictionary *itemDict in dataItems){
                ChainverseItem *item = [[ChainverseItem alloc] initWithObjectDict:itemDict];
                [items addObject:item];
            }
        }
    }
    return items;
}

+ (ChainverseItem *) parseItem:(NSArray*) data{
    NSDictionary *res = (NSDictionary *)[data objectAtIndex:0];
    ChainverseItem *item = [[ChainverseItem alloc] initWithObjectDict:res];
    [ChainverseItem archiveObject:item];
    return item;
}

+ (CVSDKTokenURI *) parseTokenUri:(id)responseObject{
    NSDictionary *result = (NSDictionary *) responseObject;
    CVSDKTokenURI *item = [[CVSDKTokenURI alloc] initWithObjectDict:result];
    return item;
}



+ (NSMutableArray *)parseServices:(NSMutableArray *)data{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSMutableArray *services = data;
    NSLog(@"nampv_parse_service %@",data);
    if(data.count > 0){
        for(NSDictionary *service in services){
            CVSDKService *item = [[CVSDKService alloc] initWithObjectDict:service];
            [items addObject:item];
        }
    }
    return items;
}

+ (NSArray *)parseRPC:(NSString *)rpcs{
    NSData* data = [rpcs dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arrayRpcs = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return arrayRpcs;
}
@end
