//
//  CVSDKConnectWalletView.m
//  Chainverse-SDK
//
//  Created by pham nam on 21/07/2021.
//

#import "CVSDKConnectWalletView.h"
#import "CVSDKDefine.h"
#import "ChainverseSDK.h"
@interface CVSDKConnectWalletView(){
    BOOL isLayoutSubview;
}
@end
@implementation CVSDKConnectWalletView

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
    self.viewContainer.layer.cornerRadius = 20.0f;
    [self initButton];
}

- (void)initButton{
    UIColor *borderColor = UIColorFromRGB(0x979797) ;

    self.btnConnectChainverse.layer.cornerRadius = 24.0f;
    self.btnConnectChainverse.layer.borderWidth = 1.0f;
    self.btnConnectChainverse.layer.borderColor = [borderColor colorWithAlphaComponent:0.3].CGColor ;
    
    [self.btnClose addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnConnectChainverse addTarget:self action:@selector(connectChainverse:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)close:(id)sender{
    [self doClose];
}



- (void)connectChainverse:(id)sender{
    [[ChainverseSDK shared] connectWithChainverse];
    [self doClose];
}

- (void)doClose{
    [self.delegate viewDidCancel:self];
}
@end
