//
//  TrustWLConnect.h
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKTrustConnect : NSObject
@property (nonatomic, strong) NSString *scheme;

/**
 Format connect Trust :  trust://sdk_get_accounts?coins.0=60&coins.1=714&app=trustsdk&callback=sdk_sign_result&id=1
 */
- (void)connect;
@end

NS_ASSUME_NONNULL_END
