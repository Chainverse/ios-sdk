//
//  CVSDKChooseWLView.m
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "CVSDKChooseWLView.h"
#import "TestScreenViewDialog.h"
@implementation CVSDKChooseWLView
- (instancetype)initView{
    if(self = [super initViewFromNib]){
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"nampv_view");
    [self.btnClose addTarget:self action:@selector(handleClose:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnNewScreen addTarget:self action:@selector(handleNewScreen:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)handleClose:(id)sender {
    [self.delegate viewDidCancel:self];
}

- (void)handleNewScreen:(id)sender {
    [TestScreenViewDialog showView];
}
@end
