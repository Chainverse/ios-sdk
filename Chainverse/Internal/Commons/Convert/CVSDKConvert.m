//
//  CVSDKConvert.m
//  Chainverse-SDK
//
//  Created by pham nam on 24/07/2021.
//

#import "CVSDKConvert.h"

@implementation CVSDKConvert
+ (BOOL) hexToBool:(NSString *)hex{
    unsigned value = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexInt:&value];
    
    BOOL output = false;
    switch ((int)value) {
        case 1:
            output = true;
            break;
        case 0:
            output = false;
            break;
    }
    
    return output;
}
@end
