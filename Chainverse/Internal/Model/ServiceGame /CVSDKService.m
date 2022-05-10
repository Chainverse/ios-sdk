//
//  CVSDKService.m
//  Chainverse-SDK
//
//  Created by pham nam on 10/05/2022.
//

#import "CVSDKService.h"

@implementation CVSDKService
- (NSString*) name{
    return [self.objectDict objectForKey:@"name"];
}
- (NSString*) type{
    return [self.objectDict objectForKey:@"type"];
}
- (NSString*) version{
    return [self.objectDict objectForKey:@"version"];
}
- (NSString*) address{
    return [self.objectDict objectForKey:@"address"];
}
- (NSString*) abi{
    return [self.objectDict objectForKey:@"abi"];
}

@end
