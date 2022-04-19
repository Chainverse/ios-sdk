//
//  CVSDKUtils.h
//  Chainverse-SDK
//
//  Created by pham nam on 14/06/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKUtils : NSObject
+ (NSString *)getValueFromQueryParam:(NSURL *)url withParam:(NSString *)param;
+ (void)openURL:(NSURL *)url;
+ (int)convertHexToDecimal:(NSString *)hex;
+ (BOOL)checkAppInstalled: (NSString *)scheme;
+ (BOOL)isChainverseInstalled;
+ (BOOL)isScreenLandcape;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (NSArray*)shuffleArray:(NSArray*)array;
@end

NS_ASSUME_NONNULL_END
