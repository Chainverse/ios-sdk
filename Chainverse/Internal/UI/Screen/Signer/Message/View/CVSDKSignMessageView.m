//
//  CVSDKSignerView.m
//  Chainverse-SDK
//
//  Created by pham nam on 04/03/2022.
//

#import "CVSDKSignMessageView.h"
#import "CVSDKDefine.h"
#import "CVSDKCallbackToGame.h"
#import "CVSDKBridgingWeb3.h"
#import "CVSDKUserDefault.h"
#import "CVSDKUtils.h"
@interface CVSDKSignMessageView(){
    BOOL isLayoutSubview;
    NSMutableDictionary *_input;
}
@end

@implementation CVSDKSignMessageView

- (instancetype)initView:(NSMutableDictionary *)input{
    if(self = [super initViewFromNib]){
        _input = input;
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(!isLayoutSubview){
        isLayoutSubview = YES;
        [self initUI];
        [self initData];
    }
}

- (void)initUI{
    self.viewMain.layer.cornerRadius = 24;
    self.viewFrom.layer.cornerRadius = 10;
    
    self.viewFrom.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.viewFrom.layer.borderWidth = 1.0f;
    if (@available(iOS 11.0, *)) {
        [self.viewMain.layer setMaskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner];
    }else{
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
        self.viewMain.layer.mask = maskLayer;
    }
    
    if (@available( iOS 11.0, * )) {
        if ([[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom > 0) {
            self.viewHeadermarginTop.constant = 30.0f;
        }else{
            self.viewHeadermarginTop.constant = 10.0f;
        }
    }
    
    self.btnSign.layer.cornerRadius = 10;
    [self.btnSign addTarget:self action:@selector(doSigner:) forControlEvents:UIControlEventTouchUpInside];
    self.lblWallet.text = [CVSDKUserDefault getXUserAdress];
    [self.btnClose addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)initData{
    NSString *type = [_input objectForKey:@"type"];
    if([type isEqualToString:@"message"]){
        NSString *message = [_input objectForKey:@"message"];
        self.tfMessage.text = message;
    }
}

- (void)doSigner:(id)sender{
    NSString *type = [_input objectForKey:@"type"];
    if([type isEqualToString:@"message"]){
        NSString *signedMessage = [[CVSDKBridgingWeb3 shared] signMessage:[_input objectForKey:@"message"]];
        [CVSDKCallbackToGame didSignMessage:signedMessage];
    }
    
    [self doClose];
}

- (void)close:(id)sender{
    [self doClose];
}

- (void)doClose{
    [self.delegate viewDidCancel:self];
}

@end
