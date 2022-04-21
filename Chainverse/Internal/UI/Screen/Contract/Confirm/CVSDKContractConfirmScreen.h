//
//  CVSDKSignTransactionScreen.h
//  Chainverse-SDK
//
//  Created by pham nam on 07/04/2022.
//

#import "CVSDKBaseViewDialog.h"
#import "CVSDKContractConfirmInput.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKContractConfirmScreen: CVSDKBaseViewDialog
+ (instancetype)show:(CVSDKContractConfirmInput *)input;
@end

NS_ASSUME_NONNULL_END
