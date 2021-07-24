//
//  CVSDKBaseResource.m
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "CVSDKBaseResource.h"
#import "CVSDKDefine.h"
@implementation CVSDKBaseResource
+ (NSBundle *)getBundle{
    if(DEBUG_CHAINVERSE_BUNDLE){
        return [NSBundle mainBundle];
    }else{
        return [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"ChainverseBundle" withExtension:@"bundle"]];
    }
}
@end
