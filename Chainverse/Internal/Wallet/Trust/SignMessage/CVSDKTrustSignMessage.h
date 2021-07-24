//
//  CVSDKTrustSignMessage.h
//  Chainverse-SDK
//
//  Created by pham nam on 13/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKTrustSignMessage : NSObject
@property (nonatomic, strong) NSString *data;
/*
 Format transfer Trust trust://sdk_sign_message?coin=60&data=b0379d0047424de9fa43620fd073532a0135cf4a85e8d7bc9ca8aae9bcd8cc4c&app=trustsdk&callback=sdk_sign_result&id=1
 **/
- (void)signMessage;
@end

NS_ASSUME_NONNULL_END
