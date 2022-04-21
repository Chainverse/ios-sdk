//
//  CVSDKSignTransactionScreen.m
//  Chainverse-SDK
//
//  Created by pham nam on 07/04/2022.
//

#import "CVSDKContractConfirmScreen.h"
#import "CVSDKContractConfirmView.h"
@implementation CVSDKContractConfirmScreen
+ (instancetype)show:(CVSDKContractConfirmInput *)input{
    CVSDKContractConfirmScreen *dialog = [[self alloc] initView:input];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView:(CVSDKContractConfirmInput *)input{
    if(self = [super init]){
        _dialogView = [[CVSDKContractConfirmView alloc] initView:input];
    }
    
    return self;
}
@end
