//
//  CVSDKWalletCreateDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletCreateScreen.h"
#import "CVSDKWalletCreateView.h"
@implementation CVSDKWalletCreateScreen
+ (instancetype)open{
    CVSDKWalletCreateScreen *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[CVSDKWalletCreateView alloc] initView];
    }
    
    return self;
}
@end
