//
//  CVSDKWalletCreateDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletBackupScreen.h"
#import "CVSDKWalletBackupView.h"
@implementation CVSDKWalletBackupScreen
+ (instancetype)open:(NSString *)type{
    CVSDKWalletBackupScreen *dialog = [[self alloc] initView:type];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView:(NSString *)type{
    if(self = [super init]){
        _dialogView = [[CVSDKWalletBackupView alloc] initView:type];
    }
    
    return self;
}
@end
