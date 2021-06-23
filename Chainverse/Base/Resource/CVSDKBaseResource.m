//
//  CVSDKBaseResource.m
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "CVSDKBaseResource.h"

@implementation CVSDKBaseResource
+ (NSBundle *)getBundle{
    BOOL isDebugResource = YES;
    if(isDebugResource){
        return [NSBundle mainBundle];
    }else{
        return [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"ChainverseBundle" withExtension:@"bundle"]];
    }
}
@end
