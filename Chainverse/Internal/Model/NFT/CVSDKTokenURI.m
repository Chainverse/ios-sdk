//
//  ChainverseItemMarket.m
//  Chainverse-SDK
//
//  Created by pham nam on 07/03/2022.
//

#import "CVSDKTokenURI.h"
#import "CVSDKParseJson.h"
@implementation CVSDKTokenURI
- (NSString*) name{
    return [self.objectDict objectForKey:@"name"];
}
- (NSString*) descriptionnft{
    return [self.objectDict objectForKey:@"description"];
}
- (NSString*) attributes{
    return [self.objectDict objectForKey:@"attributes"];
}
- (NSString*) image{
    return [self.objectDict objectForKey:@"image"];
}


@end
