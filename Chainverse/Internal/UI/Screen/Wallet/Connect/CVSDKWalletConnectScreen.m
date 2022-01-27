//
//  CVSDKWalletCreateDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletConnectScreen.h"
#import "CVSDKWalletConnectView.h"
@implementation CVSDKWalletConnectScreen

+ (instancetype)open{
    CVSDKWalletConnectScreen *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[CVSDKWalletConnectView alloc] initView];
    }
    
    return self;
}
@end
