//
//  CVSDKSignerScreen.h
//  Chainverse-SDK
//
//  Created by pham nam on 04/03/2022.
//

#import "CVSDKBaseViewDialog.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKSignMessageScreen : CVSDKBaseViewDialog
+ (instancetype)showSignerView:(NSMutableDictionary *)input;

@end

NS_ASSUME_NONNULL_END
