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

+ (UIImage*) imageNamed:(NSString*) name{
    NSString* fileName = [[name lastPathComponent] stringByDeletingPathExtension];
    NSString* extension = [name pathExtension];
    NSBundle *bundle = [self getBundle];
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:fileName ofType:extension]];
}

+ (NSString *)loadContractABI:(NSString *)resource{
    NSString *path = [[self getBundle] pathForResource:resource ofType:@"json"];
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsonString;
}
@end
