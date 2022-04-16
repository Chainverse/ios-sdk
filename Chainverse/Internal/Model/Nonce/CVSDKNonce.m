//
//  CVSDKNonce.m
//  Chainverse-SDK
//
//  Created by pham nam on 05/03/2022.
//

#import "CVSDKNonce.h"

@implementation CVSDKNonce
- (NSString *)message {
    return [self.objectDict objectForKey:@"message"];
}
- (NSString *)nonce {
    return [self.objectDict objectForKey:@"nonce"];
}
- (NSString *)time {
    return [self.objectDict objectForKey:@"time"];
}
@end
