//
//  CVSDKSignTransactionScreen.m
//  Chainverse-SDK
//
//  Created by pham nam on 07/04/2022.
//

#import "CVSDKContractCallScreen.h"
#import "CVSDKContractCallView.h"
@implementation CVSDKContractCallScreen
+ (instancetype)show:(CVSDKContractCallModel *)input{
    CVSDKContractCallScreen *dialog = [[self alloc] initView:input];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView:(CVSDKContractCallModel *)input{
    if(self = [super init]){
        _dialogView = [[CVSDKContractCallView alloc] initView:input];
    }
    
    return self;
}
@end
