//
//  CVSDKWalletCreateDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletVerifyScreen.h"
#import "CVSDKWalletVerifyView.h"
@implementation CVSDKWalletVerifyScreen
+ (instancetype)open{
    CVSDKWalletVerifyScreen *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[CVSDKWalletVerifyView alloc] initView];
    }
    
    return self;
}
@end
