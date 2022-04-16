//
//  CVSDKWalletCreateDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletExportScreen.h"
#import "CVSDKWalletExportView.h"
@implementation CVSDKWalletExportScreen
+ (instancetype)open{
    CVSDKWalletExportScreen *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[CVSDKWalletExportView alloc] initView];
    }
    
    return self;
}
@end
