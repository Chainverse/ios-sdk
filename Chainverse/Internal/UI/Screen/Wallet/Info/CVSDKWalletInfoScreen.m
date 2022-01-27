//
//  CVSDKWalletCreateDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletInfoScreen.h"
#import "CVSDKWalletInfoView.h"
@implementation CVSDKWalletInfoScreen
+ (instancetype)open{
    CVSDKWalletInfoScreen *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[CVSDKWalletInfoView alloc] initView];
    }
    
    return self;
}
@end
