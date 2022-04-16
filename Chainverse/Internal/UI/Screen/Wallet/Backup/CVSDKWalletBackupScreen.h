//
//  CVSDKWalletCreateDialog.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKBaseViewDialog.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWalletBackupScreen : CVSDKBaseViewDialog
+ (instancetype)open:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
