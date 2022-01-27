//
//  CVSDKPhrase.m
//  Chainverse-SDK
//
//  Created by pham nam on 01/12/2021.
//

#import "CVSDKPhrase.h"

@implementation CVSDKPhrase
- (NSString *)body {
    return [self.objectDict objectForKey:@"body"];
}

- (NSNumber *)order {
    return [self.objectDict objectForKey:@"order"];
}

- (NSNumber *)position {
    return [self.objectDict objectForKey:@"position"];
}

- (NSString *) isShow{
    return [self.objectDict objectForKey:@"isShow"];
}
@end
