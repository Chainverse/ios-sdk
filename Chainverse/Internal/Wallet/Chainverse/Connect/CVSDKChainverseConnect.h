//
//  CVSDKChainverseConnect.h
//  Chainverse-SDK
//
//  Created by pham nam on 16/08/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKChainverseConnect : NSObject

//chainverse://sdk_account_sign_message?action=account_sign_message&coins.0=20000714&coin=20000714&data=b0379d0047424de9fa43620fd073532a0135cf4a85e8d7bc9ca8aae9bcd8cc4c&app=trust-rn-example://&callback=sdk_account_sign_result&id=2
- (void)connect;
@end

NS_ASSUME_NONNULL_END
