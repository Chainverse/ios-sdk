//
//  CVSDKChooseWLViewDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "CVSDKChooseWLViewDialog.h"
#import "CVSDKChooseWLView.h"
@implementation CVSDKChooseWLViewDialog
+ (instancetype)showChooseView{
    CVSDKChooseWLViewDialog *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[CVSDKChooseWLView alloc] initView];
    }
    
    return self;
}
@end
