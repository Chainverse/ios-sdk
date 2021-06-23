//
//  CVSDKUtils.m
//  Chainverse-SDK
//
//  Created by pham nam on 14/06/2021.
//

#import "CVSDKUtils.h"

@implementation CVSDKUtils
+ (NSString *)getValueFromQueryParam:(NSURL *)url withParam:(NSString *)param{
    NSLog(@"CVSDK_getValueFromQueryParam %@",url);
    NSString *value = @"";
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:false];
        
    NSArray *queryItems = [components queryItems];
    if(queryItems.count > 0){
        for(NSURLQueryItem *item in queryItems){
            if([[item name] isEqualToString:param]){
                value = [item value];
                break;
            }
        }
    }
    return value;
}
@end
