//
//  CVSDKUtils.h
//  Chainverse-SDK
//
//  Created by pham nam on 14/06/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKUtils : NSObject
+ (NSString *)getValueFromQueryParam:(NSURL *)url withParam:(NSString *)param;
@end

NS_ASSUME_NONNULL_END
