//
//  CVSDKConnectWalletDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 21/07/2021.
//

#import "CVSDKConnectWalletDialog.h"
#import "CVSDKConnectWalletView.h"
@implementation CVSDKConnectWalletDialog
+ (instancetype)showConnectView{
    CVSDKConnectWalletDialog *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[CVSDKConnectWalletView alloc] initView];
    }
    
    return self;
}
@end
