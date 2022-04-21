//
//  CVSDKWalletCreateView.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletImportView.h"
#import "CVSDKUtils.h"
#import "CVSDKBaseResource.h"
#import "CVSDKBridgingWallet.h"
#import "CVSDKUserDefault.h"
#import "CVSDKWalletBackupScreen.h"
#import "CVSDKBridgingWallet.h"
#import "CVSDKBridgingWeb3.h"
#import "CVSDKConstant.h"
@interface CVSDKWalletImportView()<UITextViewDelegate>{
    BOOL isLayoutSubview;
}
@end
@implementation CVSDKWalletImportView

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
    
    self.viewError.hidden = YES;
    
    self.viewInput.layer.cornerRadius = 10;
    self.viewInput.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.viewInput.layer.borderWidth = 1.0f;
    
    self.btnPaste.layer.cornerRadius = 10;
    self.btnPaste.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.btnPaste.layer.borderWidth = 1.0f;
    self.inputPhrase.delegate = self;
    
    self.btnImport.layer.cornerRadius = 10;
    [self.btnBack addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnImport addTarget:self action:@selector(importPhrase:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPaste addTarget:self action:@selector(pastePhrase:) forControlEvents:UIControlEventTouchUpInside];
    [self handleHideKeyboard];
    [self.inputPhrase becomeFirstResponder];
    self.inputPhrase.text = @"shoot team crush innocent sword wagon loud simple pig month degree melt";
    
    if (@available( iOS 11.0, * )) {
        if ([[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom > 0) {
            self.viewHeadermarginTop.constant = 30.0f;
        }else{
            self.viewHeadermarginTop.constant = 10.0f;
        }
    }
}

- (void)handleHideKeyboard{
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    click.numberOfTapsRequired = 1;
    [self.viewMain setUserInteractionEnabled:YES];
    [self.viewMain addGestureRecognizer:click];
}

-(void)hideKeyboard{
    [self endEditing:YES];
}


- (void)close:(id)sender {
    [self doClose];
}


- (void)doClose{
    [self.delegate viewDidCancel:self];
}

- (void)importPhrase:(id)sender {
    if(self.inputPhrase.text.length > 0){
        NSString *xUserAddress = [[CVSDKBridgingWallet shared]importWallet:self.inputPhrase.text];
        if(![xUserAddress isEqualToString:@""]){
            [CVSDKUserDefault setMnemonic:self.inputPhrase.text];
            //NSString *signedMessage = [[CVSDKBridgingWeb3 shared] signMessage:@"ChainVerse"];
            NSString *signedMessage = [[CVSDKBridgingWeb3 shared] signPersonalMessage:@"ChainVerse"];
            NSLog(@"nampv_signed %@",signedMessage);
            [CVSDKUserDefault setXUserAddress:xUserAddress];
            [CVSDKUserDefault setXUserSignature:signedMessage];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CONNECT_SUCCESS object:self];
            [self doClose];
        }else{
            self.viewError.hidden = NO;
        }
    }else{
        self.viewError.hidden = NO;
    }
}

- (void)pastePhrase:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    self.inputPhrase.text = pasteboard.string;
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.btnImport.enabled = true;
    self.btnImport.backgroundColor = [CVSDKUtils colorWithHexString:@"#077DC5"];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.btnImport.enabled = true;
    self.btnImport.backgroundColor = [CVSDKUtils colorWithHexString:@"#077DC5"];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.btnImport.enabled = true;
    self.btnImport.backgroundColor = [CVSDKUtils colorWithHexString:@"#077DC5"];
}
@end
