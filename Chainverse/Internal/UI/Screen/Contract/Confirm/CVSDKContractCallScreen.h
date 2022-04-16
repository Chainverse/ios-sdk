//
//  CVSDKSignTransactionScreen.h
//  Chainverse-SDK
//
//  Created by pham nam on 07/04/2022.
//

#import "CVSDKBaseViewDialog.h"
#import "CVSDKContractCallModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKContractCallScreen : CVSDKBaseViewDialog
+ (instancetype)show:(CVSDKContractCallModel *)input;
@end

NS_ASSUME_NONNULL_END
