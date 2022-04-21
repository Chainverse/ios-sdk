//
//  CVSDKUtils.m
//  Chainverse-SDK
//
//  Created by pham nam on 14/06/2021.
//

#import "CVSDKUtils.h"
#import "UIKit/UIKit.h"
#import "ChainverseTokenSupport.h"
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

+ (void)openURL:(NSURL *)url{
    if (@available(iOS 10.0, *)){
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
              [[UIApplication sharedApplication]
                          openURL:url options:@{}
                          completionHandler:nil];
          }
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }

}

+ (int)convertHexToDecimal:(NSString *)hex{
    unsigned value = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexInt:&value];
    return (int)value;
}

+ (BOOL)checkAppInstalled:(NSString *)scheme{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    return [application canOpenURL:URL];
}

+ (BOOL)isChainverseInstalled{
    if(![self checkAppInstalled:@"chainverse://"]){
        [self openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1580411367"]];
        return false;
    }
    return true;
    
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];

    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (NSArray*)shuffleArray:(NSArray*)array{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:array];
    for(NSUInteger i = [array count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform(i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }

    return [NSArray arrayWithArray:temp];
}

+ (BOOL)isScreenLandcape{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        return true;
    } else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return false;
    }
    return false;
}

+ (NSString *)getCurrency:(NSString *)token{
    NSString *currency = @"CVT";
    if([token isEqualToString:TOKEN_CVT]){
        currency = @"CVT";
    }else if([token isEqualToString:TOKEN_USDT]){
        currency = @"USDT";
    }
    return currency;
}
@end
