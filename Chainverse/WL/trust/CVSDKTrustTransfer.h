//
//  TrustWLTransfer.h
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKTrustTransfer : NSObject
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *asset;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *feePrice;
@property (nonatomic, strong) NSString *feeLimit;
/*
 Format transfer Trust trust://sdk_transaction?action=transfer&amount=0.01&asset=c60&confirm_type=sign&fee_limit=21000&fee_price=2112000000&nonce=447&to=0x728B02377230b5df73Aa4E3192E89b6090DD7312&app=trustsdk&callback=sdk_sign_result&id=3
 **/
- (void)transfer;
@end

NS_ASSUME_NONNULL_END
