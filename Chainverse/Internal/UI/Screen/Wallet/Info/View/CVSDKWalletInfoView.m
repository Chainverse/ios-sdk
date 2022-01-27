//
//  CVSDKWalletCreateView.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletInfoView.h"
#import "CVSDKUtils.h"
#import "CVSDKBaseResource.h"
#import "CVSDKWallet.h"
#import "CVSDKUserDefault.h"
#import "CVSDKWalletBackupScreen.h"
#import "CVSDKWalletExportScreen.h"
@interface CVSDKWalletInfoView(){
    BOOL isLayoutSubview;
}
@end
@implementation CVSDKWalletInfoView

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
    
    self.btnExportPrivateKey.layer.cornerRadius = 20;
    self.btnExportPrivateKey.layer.borderColor = [CVSDKUtils colorWithHexString:@"#077DC5"].CGColor;
    self.btnExportPrivateKey.layer.borderWidth = 1.0f;
    
    self.btnRecovery.layer.cornerRadius = 20;
    self.btnRecovery.layer.borderColor = [CVSDKUtils colorWithHexString:@"#077DC5"].CGColor;
    self.btnRecovery.layer.borderWidth = 1.0f;
    
    [self.btnBack addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRecovery addTarget:self action:@selector(recoveryPhrase:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnExportPrivateKey addTarget:self action:@selector(exportPrivateKey:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lblAddress.text = [CVSDKWallet importWallet:[CVSDKUserDefault getMnemonic]];
    self.lblAddress.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLabelWithGesture:)];
    [self.lblAddress addGestureRecognizer:tapGesture];
    
    self.viewCopiedAddress.hidden = YES;
        
    
}

- (void)didTapLabelWithGesture:(UITapGestureRecognizer *)tapGesture {
    self.viewCopiedAddress.hidden = NO;
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

- (void)exportPrivateKey:(id)sender {
    [CVSDKWalletExportScreen open];
    [self doClose];
}
@end
