//
//  CVSDKWalletCreateView.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletCreateView.h"
#import "CVSDKUtils.h"
#import "CVSDKBaseResource.h"
#import "CVSDKWallet.h"
#import "CVSDKUserDefault.h"
#import "CVSDKWalletBackupScreen.h"
@interface CVSDKWalletCreateView(){
    BOOL isLayoutSubview;
}
@end
@implementation CVSDKWalletCreateView

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
    
    self.view12Words.layer.cornerRadius = 10;
    self.view12Words.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.view12Words.layer.borderWidth = 1.0f;
    
    self.view24Words.layer.cornerRadius = 10;
    self.view24Words.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.view24Words.layer.borderWidth = 1.0f;
    
    self.btnCreate.layer.cornerRadius = 10;
    
    [self.btnBack addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn24Words setImage:[CVSDKBaseResource imageNamed:@"chainverse_checkbox_uncheck.png"] forState:UIControlStateNormal];
    [self.btn24Words setImage:[CVSDKBaseResource imageNamed:@"chainverse_checkbox_checked.png"] forState:UIControlStateSelected];
    [self.btn24Words addTarget:self action:@selector(check24Words:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn12Words setImage:[CVSDKBaseResource imageNamed:@"chainverse_checkbox_uncheck.png"] forState:UIControlStateNormal];
    [self.btn12Words setImage:[CVSDKBaseResource imageNamed:@"chainverse_checkbox_checked.png"] forState:UIControlStateSelected];
    [self.btn12Words addTarget:self action:@selector(check12Words:) forControlEvents:UIControlEventTouchUpInside];
    self.btn12Words.selected = true;
    
    
    [self.btnTerm setImage:[CVSDKBaseResource imageNamed:@"chainverse_checkbox_uncheck.png"] forState:UIControlStateNormal];
    [self.btnTerm setImage:[CVSDKBaseResource imageNamed:@"chainverse_checkbox_checked.png"] forState:UIControlStateSelected];
    [self.btnTerm addTarget:self action:@selector(checkTerm:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnCreate addTarget:self action:@selector(createMnemonic:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)close:(id)sender {
    [self doClose];
}


- (void)doClose{
    [self.delegate viewDidCancel:self];
}

- (void)check12Words:(id)sender {
    self.btn12Words.selected = !self.btn12Words.selected;
    self.btn24Words.selected = false;
}

- (void)check24Words:(id)sender {
    self.btn24Words.selected = !self.btn24Words.selected;
    self.btn12Words.selected = false;
}

- (void)checkTerm:(id)sender {
    self.btnTerm.selected = !self.btnTerm.selected;
    
    if(self.btnTerm.isSelected){
        self.btnCreate.enabled = true;
        self.btnCreate.backgroundColor = [CVSDKUtils colorWithHexString:@"#077DC5"];
    }else{
        self.btnCreate.enabled = false;
        self.btnCreate.backgroundColor = [CVSDKUtils colorWithHexString:@"#B5B5B5"];
    }
    
}

- (void)createMnemonic:(id)sender {
    NSInteger length = 128;
    if(self.btn24Words.isSelected){
        length = 256;
    }
    NSString *mnemonic = [CVSDKWallet createMnemonics:&length];
    [CVSDKUserDefault setMnemonic:mnemonic];
    [CVSDKWalletBackupScreen open:@"default"];
    [self doClose];
}
@end
