//
//  ChainverseUser.m
//  Chainverse-SDK
//
//  Created by pham nam on 01/09/2021.
//

#import "ChainverseUser.h"

@implementation ChainverseUser
- (NSString *)address {
    return [self.objectDict objectForKey:@"address"];
}

- (NSString *)signature {
    return [self.objectDict objectForKey:@"signature"];
}
@end
