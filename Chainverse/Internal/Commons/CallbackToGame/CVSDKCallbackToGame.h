//
//  CVSDKCallbackToGame.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKCallbackToGame : NSObject
+ (void)didUserAddress:(NSString *)address;
+ (void)didUserLogout:(NSString *)address;
+ (void)didInitSDKSuccess;
+ (void)didError:(int) error;
@end

NS_ASSUME_NONNULL_END
