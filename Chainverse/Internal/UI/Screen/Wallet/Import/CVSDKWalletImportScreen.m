//
//  CVSDKWalletCreateDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletImportScreen.h"
#import "CVSDKWalletImportView.h"
@implementation CVSDKWalletImportScreen
+ (instancetype)open{
    CVSDKWalletImportScreen *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[CVSDKWalletImportView alloc] initView];
    }
    
    return self;
}
@end
