//
//  CVSDKSignTransactionView.m
//  Chainverse-SDK
//
//  Created by pham nam on 07/04/2022.
//

#import "CVSDKContractConfirmView.h"
#import "CVSDKCallbackToGame.h"
#import "CVSDKUtils.h"
#import "CVSDKUserDefault.h"
#import "CVSDKBridgingWeb3.h"
#import "CVSDKContractManager.h"
#import "CVSDKDefine.h"
@interface CVSDKContractConfirmView(){
    BOOL isLayoutSubview;
    CVSDKContractConfirmInput *_input;
}
@end

@implementation CVSDKContractConfirmView

- (instancetype)initView:(CVSDKContractConfirmInput *)input{
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
    self.viewFee.layer.cornerRadius = 10;
    self.viewFee.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.viewFee.layer.borderWidth = 1.0f;
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
    [self.btnSign addTarget:self action:@selector(doConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnClose addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)initData{
    self.lblHeadTitle.text = _input.headTitle;
    self.lblValue.text = _input.name;
    self.lblAsset.text = _input.asset;
    self.lblFrom.text = [self handleAddress:_input.from];
    self.lblTo.text = [self handleAddress:_input.granted_to];
    self.lblContract.text = [self handleAddress:_input.contract];
    self.lblFee.text = [NSString stringWithFormat:@"%f BNB",[_input.fee floatValue]];
    self.lblTotal.text = [NSString stringWithFormat:@"%f BNB",[_input.fee floatValue]];
    
    if([_input.asset isEqualToString:@""]){
        self.viewAsset.hidden = YES;
        self.heightViewFrom.constant = 140;
        self.viewFromMarginTop.constant = -30;
    }
    
    if([_input.function isEqualToString:@"buyNFT"]){
        NSMutableDictionary *params = _input.params;
        NSString *currency = [params objectForKey:@"currency"];
        if([currency isEqualToString:@"0x0000000000000000000000000000000000000000"]){
            NSString *price = [params objectForKey:@"price"];
            float total = [price floatValue] + [_input.fee floatValue];
            self.lblTotal.text = [NSString stringWithFormat:@"%f BNB",total];
        }
    }
    
}


- (void)doConfirm:(id)sender{
    if([_input.function isEqualToString:@"approveNFT"]){
        NSMutableDictionary *params = _input.params;
        NSString *nft = [params objectForKey:@"nft"];
        NSNumber *tokenId = [params objectForKey:@"tokenId"];
        NSString *tx = [[CVSDKContractManager shared] approveNFT:nft tokenId:[tokenId integerValue]];
        [CVSDKCallbackToGame didTransact:approveNFT tx:tx];
    }else if([_input.function isEqualToString:@"transferItem"]){
        NSMutableDictionary *params = _input.params;
        NSString *to = [params objectForKey:@"to"];
        NSString *nft = [params objectForKey:@"nft"];
        NSNumber *tokenId = [params objectForKey:@"tokenId"];
        NSString *tx = [[CVSDKContractManager shared] transferItem:to nft:nft tokenId:[tokenId integerValue]];
        [CVSDKCallbackToGame didTransact:transferItem tx:tx];
    }else if([_input.function isEqualToString:@"approveToken"]){
        NSMutableDictionary *params = _input.params;
        NSString *token = [params objectForKey:@"token"];
        NSString *amount = [params objectForKey:@"amount"];
        NSString *tx = [[CVSDKContractManager shared] approveToken:token spender:@"0x2ccA92F66BeA2A7fA2119B75F3e5CB698C252564" amount:[NSString stringWithFormat:@"%@",amount]];
        [CVSDKCallbackToGame didTransact:approveToken tx:tx];
    }else if([_input.function isEqualToString:@"buyNFT"]){
        NSMutableDictionary *params = _input.params;
        NSString *currency = [params objectForKey:@"currency"];
        NSNumber *listingId = [params objectForKey:@"listingId"];
        NSString *price = [params objectForKey:@"price"];
        NSString *tx = [[CVSDKContractManager shared] buyNFT:currency listingId:[listingId integerValue] price:price];
        [CVSDKCallbackToGame didTransact:buyNFT tx:tx];
    }else if([_input.function isEqualToString:@"sellNFT"]){
        NSMutableDictionary *params = _input.params;
        NSString *NFT = [params objectForKey:@"NFT"];
        NSNumber *tokenId = [params objectForKey:@"tokenId"];
        NSString *price = [params objectForKey:@"price"];
        NSString *currency = [params objectForKey:@"currency"];
        
        NSString *tx = [[CVSDKContractManager shared] sellNFT:NFT tokenId:[tokenId integerValue] price:price currency:currency];
        [CVSDKCallbackToGame didTransact:sellNFT tx:tx];
    }else if([_input.function isEqualToString:@"cancelSellNFT"]){
        NSMutableDictionary *params = _input.params;
        NSNumber *listingId = [params objectForKey:@"listingId"];
        NSString *tx = [[CVSDKContractManager shared] cancelSellNFT:[listingId integerValue]];
        [CVSDKCallbackToGame didTransact:cancelSell tx:tx];
    }
    
    
    [self doClose];
}

- (NSString *)handleAddress:(NSString *)input{
    NSString *output1 = [input substringToIndex:7];
    NSString *output2 = [input substringFromIndex:34];
    return [NSString stringWithFormat:@"%@...%@",output1,output2];
}

- (void)close:(id)sender{
    [self doClose];
}

- (void)doClose{
    [self.delegate viewDidCancel:self];
}

@end
