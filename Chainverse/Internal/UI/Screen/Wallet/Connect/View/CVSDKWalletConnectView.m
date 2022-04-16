//
//  CVSDKWalletCreateView.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletConnectView.h"
#import "CVSDKUtils.h"
#import "CVSDKBaseResource.h"
#import "CVSDKBridgingWallet.h"
#import "CVSDKUserDefault.h"
#import "CVSDKWalletBackupScreen.h"
#import "CVSDKWalletCreateScreen.h"
#import "CVSDKWalletImportScreen.h"
@interface CVSDKWalletConnectView(){
    BOOL isLayoutSubview;
}
@end
@implementation CVSDKWalletConnectView

- (instancetype)initView{
    if(self = [super initViewFromNib]){
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(!isLayoutSubview){
        isLayoutSubview = YES;
        [self initUI];
    }
}

- (void)initUI{
    
    self.btnCreate.layer.cornerRadius = 10;
    self.btnImport.layer.cornerRadius = 10;
    self.btnImport.layer.borderColor = [CVSDKUtils colorWithHexString:@"#FFFFFF"].CGColor;
    self.btnImport.layer.borderWidth = 1.0f;
    
    [self.btnBack addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCreate addTarget:self action:@selector(createWallet:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnImport addTarget:self action:@selector(importWallet:) forControlEvents:UIControlEventTouchUpInside];
    
    if (@available( iOS 11.0, * )) {
        if ([[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom > 0) {
            self.viewHeadermarginTop.constant = 30.0f;
        }else{
            self.viewHeadermarginTop.constant = 10.0f;
        }
    }
}

- (void)close:(id)sender {
    [self doClose];
}


- (void)doClose{
    [self.delegate viewDidCancel:self];
}

- (void)createWallet:(id)sender {
    [CVSDKWalletCreateScreen open];
    [self doClose];
}

- (void)importWallet:(id)sender {
    [CVSDKWalletImportScreen open];
    [self doClose];
}
@end
