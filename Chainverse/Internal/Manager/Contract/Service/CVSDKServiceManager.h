//
//  CVSDKServiceManager.h
//  Chainverse-SDK
//
//  Created by pham nam on 09/03/2022.
//

#import <Foundation/Foundation.h>
#import "CVSDKService.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKServiceManager : NSObject
+ (CVSDKServiceManager *) shared;
- (void)initialize:(NSString *)address;
- (CVSDKService *)getSevice;
@end

NS_ASSUME_NONNULL_END
