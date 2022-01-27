//
//  CVSDKWalletCreateView.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletExportView.h"
#import "CVSDKUtils.h"
#import "CVSDKBaseResource.h"
#import "CVSDKWallet.h"
#import "CVSDKUserDefault.h"
#import "CVSDKWalletBackupScreen.h"
@interface CVSDKWalletExportView(){
    BOOL isLayoutSubview;
}
@end
@implementation CVSDKWalletExportView

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
    self.viewMain.layer.cornerRadius = 24;
    if (@available(iOS 11.0, *)) {
        [self.viewMain.layer setMaskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner];
    }else{
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
        self.viewMain.layer.mask = maskLayer;
    }
    
    self.viewAddress.layer.cornerRadius = 0;
    self.viewAddress.layer.borderColor = [CVSDKUtils colorWithHexString:@"#CCCCCC"].CGColor;
    self.viewAddress.layer.borderWidth = 1.0f;
    
    self.viewPrivateKey.layer.cornerRadius = 0;
    self.viewPrivateKey.layer.borderColor = [CVSDKUtils colorWithHexString:@"#CCCCCC"].CGColor;
    self.viewPrivateKey.layer.borderWidth = 1.0f;
    
    self.btnExportPrivateKey.layer.cornerRadius = 20;
    self.btnExportPrivateKey.layer.borderColor = [CVSDKUtils colorWithHexString:@"#077DC5"].CGColor;
    self.btnExportPrivateKey.layer.borderWidth = 1.0f;
    
    self.btnRecovery.layer.cornerRadius = 20;
    self.btnRecovery.layer.borderColor = [CVSDKUtils colorWithHexString:@"#077DC5"].CGColor;
    self.btnRecovery.layer.borderWidth = 1.0f;
    
    [self.btnBack addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRecovery addTarget:self action:@selector(recoveryPhrase:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lblAddress.text = [CVSDKWallet importWallet:[CVSDKUserDefault getMnemonic]];
    self.lblAddress.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapCopyAddress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCopyAddress:)];
    [self.lblAddress addGestureRecognizer:tapCopyAddress];
    
    self.viewCopiedAddress.hidden = YES;
    self.heightViewCopiedAddress.constant = 0;
    self.viewCopiedPrivateKey.hidden = YES;
    self.heightViewCopiedPrivateKey.constant = 0;
    
    self.lblPrivateKey.text = [CVSDKWallet getPrivateKey];
    self.lblPrivateKey.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapCopyPrivateKey = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCopyPrivateKey:)];
    [self.lblPrivateKey addGestureRecognizer:tapCopyPrivateKey];
        
    
}

- (void)didTapCopyAddress:(UITapGestureRecognizer *)tapGesture {
    self.viewCopiedAddress.hidden = NO;
    self.heightViewCopiedAddress.constant = 30;
    self.heightViewCopiedPrivateKey.constant = 30;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [CVSDKWallet importWallet:[CVSDKUserDefault getMnemonic]];
}

- (void)didTapCopyPrivateKey:(UITapGestureRecognizer *)tapGesture {
    self.viewCopiedPrivateKey.hidden = NO;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [CVSDKWallet getPrivateKey];
}

- (void)close:(id)sender {
    [self doClose];
}


- (void)doClose{
    [self.delegate viewDidCancel:self];
}



- (void)recoveryPhrase:(id)sender {
    [CVSDKWalletBackupScreen open:@"recovery"];
    [self doClose];
}
@end
