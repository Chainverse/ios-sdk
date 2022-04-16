//
//  CVSDKSignerScreen.m
//  Chainverse-SDK
//
//  Created by pham nam on 04/03/2022.
//

#import "CVSDKSignMessageScreen.h"
#import "CVSDKSignMessageView.h"
@implementation CVSDKSignMessageScreen
+ (instancetype)showSignerView:(NSMutableDictionary *)input{
    CVSDKSignMessageScreen *dialog = [[self alloc] initView:input];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView:(NSMutableDictionary *)input{
    if(self = [super init]){
        _dialogView = [[CVSDKSignMessageView alloc] initView:input];
    }
    
    return self;
}
@end
