//
//  TestScreenViewDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "TestScreenViewDialog.h"
#import "TestScreenView.h"
@implementation TestScreenViewDialog
+ (instancetype)showView{
    TestScreenViewDialog *dialog = [[self alloc] initView];
    dialog.delegate = nil;
    [dialog showDialog];
    return dialog;
}

- (instancetype)initView{
    if(self = [super init]){
        _dialogView = [[TestScreenView alloc] initView];
    }
    
    return self;
}
@end
