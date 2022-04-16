//
//  CVSDKServiceManager.m
//  Chainverse-SDK
//
//  Created by pham nam on 09/03/2022.
//

#import "CVSDKServiceManager.h"
#import "CVSDKServiceGame.h"
#import "CVSDKService.h"
@interface CVSDKServiceManager(){
    NSString *_address;
}
@end
@implementation CVSDKServiceManager
+ (CVSDKServiceManager *)shared{
    static CVSDKServiceManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)initialize:(NSString *)address{
    _address = address;
}

- (CVSDKService *)getSevice{
    CVSDKServiceGame *serviceGame = [CVSDKServiceGame getArchivedObjectWithClass:[CVSDKServiceGame class]];
    NSMutableArray *services = serviceGame.services;
    if(services.count > 0){
        for(NSDictionary *service in services){
            CVSDKService *item = (CVSDKService *)service;
            if([_address isEqualToString:item.address]){
                return item;
            }
        }
    }
    return nil;
}
@end
