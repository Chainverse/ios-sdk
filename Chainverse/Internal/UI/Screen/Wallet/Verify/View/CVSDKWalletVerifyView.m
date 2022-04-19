//
//  CVSDKWalletCreateView.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletVerifyView.h"
#import "CVSDKUtils.h"
#import "CVSDKBaseResource.h"
#import "CVSDKBridgingWallet.h"
#import "CVSDKUserDefault.h"
#import "CVSDKPhrase.h"
#import "CVSDKPhraseViewCell.h"
#import "CVSDKPhraseVerifyViewCell.h"
#import "CVSDKBridgingWallet.h"
#import "CVSDKBridgingWeb3.h"
#import "CVSDKConstant.h"
@interface CVSDKWalletVerifyView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    BOOL isLayoutSubview;
    NSMutableArray *_phrasesVerify;
    NSMutableArray *_phrasesRandom;
    NSMutableArray *_phrasesChoose;
    NSInteger _phraseVerifyPosition;
    NSString *_mnemonicChoose;
    NSArray *_phrasesRandomTmp;
}
@end
@implementation CVSDKWalletVerifyView

- (instancetype)initView{
    if(self = [super initViewFromNib]){
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(!isLayoutSubview){
        isLayoutSubview = YES;
        _phrasesChoose =  [[NSMutableArray alloc] init];
        
        [self initUI];
        [self initCollectionView];
        [self initPhraseVerify];
        [self initPhraseRandom];
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
    
    [self.btnBack addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnVerify.layer.cornerRadius = 10;
    [self.btnVerify addTarget:self action:@selector(verify:) forControlEvents:UIControlEventTouchUpInside];
    self.btnVerify.enabled = false;
    self.btnVerify.backgroundColor = [CVSDKUtils colorWithHexString:@"#B5B5B5"];
    
    self.viewPhraseVerify.layer.cornerRadius = 10;
    self.viewPhraseVerify.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.viewPhraseVerify.layer.borderWidth = 1.0f;
    
    self.viewPhraseRandom.layer.cornerRadius = 10;
    self.viewPhraseRandom.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.viewPhraseRandom.layer.borderWidth = 1.0f;
    
    self.viewMessageError.hidden = YES;
    
    if (@available( iOS 11.0, * )) {
        if ([[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom > 0) {
            self.viewHeadermarginTop.constant = 30.0f;
        }else{
            self.viewHeadermarginTop.constant = 10.0f;
        }
    }
}


- (void)initCollectionView{
    self.collectionViewPhraseVerify.dataSource = self;
    self.collectionViewPhraseVerify.delegate = self;
    [self.collectionViewPhraseVerify registerNib:[CVSDKPhraseVerifyViewCell nib] forCellWithReuseIdentifier:[CVSDKPhraseVerifyViewCell nibName]];
    
    
    self.collectionViewPhraseRandom.dataSource = self;
    self.collectionViewPhraseRandom.delegate = self;
    [self.collectionViewPhraseRandom registerNib:[CVSDKPhraseViewCell nib] forCellWithReuseIdentifier:[CVSDKPhraseViewCell nibName]];
}

#pragma collection view
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView == self.collectionViewPhraseVerify){
        return [_phrasesVerify count];
    }
    return [_phrasesRandom count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView == self.collectionViewPhraseVerify){
        CGFloat cellWidth = (CGRectGetWidth(self.collectionViewPhraseVerify.frame) - 5 * 4)/3;
        if([CVSDKUtils isScreenLandcape]){
            cellWidth = (CGRectGetWidth(self.collectionViewPhraseVerify.frame) - 5 * 4)/6;
        }
        
        return CGSizeMake(cellWidth, 30);
    }else{
        CGFloat cellWidth = (CGRectGetWidth(self.collectionViewPhraseRandom.frame) - 5 * 4)/3;
        if([CVSDKUtils isScreenLandcape]){
            cellWidth = (CGRectGetWidth(self.collectionViewPhraseRandom.frame) - 5 * 4)/6;
        }
        return CGSizeMake(cellWidth, 30);
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    if(collectionView == self.collectionViewPhraseVerify){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CVSDKPhraseVerifyViewCell nibName] forIndexPath:indexPath];
        [((CVSDKPhraseVerifyViewCell *)cell) setupData:[_phrasesVerify objectAtIndex:indexPath.row] atIndexPath:indexPath];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CVSDKPhraseViewCell nibName] forIndexPath:indexPath];
        [((CVSDKPhraseViewCell *)cell) setupData:[_phrasesRandom objectAtIndex:indexPath.row] atIndexPath:indexPath type:@"random"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView == self.collectionViewPhraseVerify){
        [self movePhraseVerifyToRandom:indexPath];
    }else if(collectionView == self.collectionViewPhraseRandom){
        [self movePhraseRandomToVerify:indexPath];
    }
}

- (void)handleDataVerifyAfterRemove:(NSIndexPath *)indexPath{
    if([_phrasesVerify count] > 0){
        for (int i = 0; i < [_phrasesVerify count]; i++) {
            CVSDKPhrase *phraseVerifyCurrent =  _phrasesVerify[i];
            if(i >= indexPath.row){
                if(i < [_phrasesVerify count] - 1){
                    int pos = i + 1;
                    CVSDKPhrase *phraseVerifyNext =  _phrasesVerify[pos];
                    CVSDKPhrase *phraseVerifyUpdate = [self createPhrase:[phraseVerifyNext body] order:[phraseVerifyCurrent order] position:[phraseVerifyNext position] ? [phraseVerifyNext position] : [NSNumber numberWithInteger:0] show:[phraseVerifyNext isShow]];
                    [_phrasesVerify replaceObjectAtIndex:i withObject:phraseVerifyUpdate];
                }else{
                    CVSDKPhrase *phraseVerifyUpdate = [self createPhrase:@"" order:[phraseVerifyCurrent order] position:[NSNumber numberWithInteger:0] show:@"false"];
                    [_phrasesVerify replaceObjectAtIndex:i withObject:phraseVerifyUpdate];
                }
            }
            
        }
    }
}

- (void)movePhraseVerifyToRandom:(NSIndexPath *)indexPath{
    CVSDKPhrase *phraseVerify =  _phrasesVerify[indexPath.row];
    CVSDKPhrase *phraseRandom =  _phrasesRandom[[[phraseVerify position] integerValue]];
    if([[phraseVerify isShow] isEqualToString:@"false"]){
        return;
    }
    
    if(_phraseVerifyPosition > 0){
        //Update collectionViewVerify
        CVSDKPhrase *phraseVerifyUpdate = [self createPhrase:[phraseVerify body] order:[phraseVerify order] position:[phraseVerify position] show:@"false"];
        [_phrasesVerify replaceObjectAtIndex:indexPath.row withObject:phraseVerifyUpdate];
        [self handleDataVerifyAfterRemove:indexPath];
        [self.collectionViewPhraseVerify reloadData];
        
        //Update collectionViewRandom
        CVSDKPhrase *phraseRandomUpdate = [self createPhrase:[phraseRandom body] order:[phraseRandom order] position:[phraseVerify position] show:@"true"];
        [_phrasesRandom replaceObjectAtIndex:[[phraseVerify position] integerValue] withObject:phraseRandomUpdate];
        [self.collectionViewPhraseRandom reloadData];
        
        if([_phrasesChoose count] > 0){
            [_phrasesChoose removeObject:phraseRandom];
        }
        
        [self checkPhraseOrder];
        
        _phraseVerifyPosition--;
        if(_phraseVerifyPosition < [_phrasesVerify count]){
            self.btnVerify.enabled = false;
            self.btnVerify.backgroundColor = [CVSDKUtils colorWithHexString:@"#B5B5B5"];
        }
    }
    
}

- (bool)isVerifyMnemonic{
    _mnemonicChoose = @"";
    if([_phrasesChoose count] > 0){
        if([_phrasesChoose count] == [_phrasesVerify count]){
            for (int i = 0; i < [_phrasesChoose count]; i++) {
                CVSDKPhrase *phraseCheck = _phrasesChoose[i];
                if(i == 0){
                    _mnemonicChoose = [_mnemonicChoose stringByAppendingString:[phraseCheck body]];
                }else{
                    _mnemonicChoose = [_mnemonicChoose stringByAppendingString:[NSString stringWithFormat:@" %@",[phraseCheck body]]];
                }
            }
            
            if([[[CVSDKBridgingWallet shared] getMnemonic] isEqualToString:_mnemonicChoose]){
                return true;
            }
            return false;
        }
    }
    return false;
}

- (void)checkPhraseOrder{
    NSLog(@"nampv_coun %lu",[_phrasesChoose count]);
    if([_phrasesChoose count] > 0){
        bool isRight = false;
        for (int i = 0; i < [_phrasesChoose count]; i++) {
            CVSDKPhrase *phraseVerify =  _phrasesVerify[i];
            CVSDKPhrase *phraseCheck = _phrasesChoose[i];
            if([[phraseCheck order] intValue] == [[phraseVerify order] intValue]){
                isRight = true;
            }else{
                isRight = false;
                break;
            }
        }
        
        if(isRight){
            self.viewMessageError.hidden = YES;
        }else{
            self.viewMessageError.hidden = NO;
        }
    }else{
        self.viewMessageError.hidden = YES;
    }
}

- (void)movePhraseRandomToVerify:(NSIndexPath *)indexPath{
    //Update collectionViewVerify
    CVSDKPhrase *phraseRandom =  _phrasesRandom[indexPath.row];
    CVSDKPhrase *phraseVerify =  _phrasesVerify[_phraseVerifyPosition];
    if([[phraseRandom isShow] isEqualToString:@"false"]){
        return;
    }
    
    if(_phraseVerifyPosition < [_phrasesVerify count]){
        CVSDKPhrase *phraseVerifyUpdate = [self createPhrase:[phraseRandom body] order:[phraseVerify order] position:[NSNumber numberWithInteger:indexPath.row] show:@"true"];
        [_phrasesVerify replaceObjectAtIndex:_phraseVerifyPosition withObject:phraseVerifyUpdate];
        [self.collectionViewPhraseVerify reloadData];
        
        CVSDKPhrase *phraseRandomUpdate = [self createPhrase:[phraseRandom body] order:[phraseRandom order] position:[NSNumber numberWithInteger:indexPath.row] show:@"false"];
        [_phrasesRandom replaceObjectAtIndex:indexPath.row withObject:phraseRandomUpdate];
        [self.collectionViewPhraseRandom reloadData];
        
        if(![_phrasesChoose containsObject:phraseRandomUpdate]){
            [_phrasesChoose addObject:phraseRandomUpdate];
        }
        
        [self checkPhraseOrder];
        _phraseVerifyPosition++;
        
        if(_phraseVerifyPosition == [_phrasesVerify count]){
            if([self isVerifyMnemonic]){
                self.btnVerify.enabled = true;
                self.btnVerify.backgroundColor = [CVSDKUtils colorWithHexString:@"#077DC5"];
            }
        }
    }
    
}

- (CVSDKPhrase *)createPhrase:(NSString *)body order:(NSNumber *)order position:(NSNumber *)position show:(NSString *)show{
    NSDictionary *dict;
    if(position != nil){
        dict = @{
            @"body" : body,
            @"order" : order,
            @"position" : position,
            @"isShow" : show
        };
    }else{
        dict = @{
            @"body" : body,
            @"order" : order,
            @"isShow" : show
        };
    }
    
    return [[CVSDKPhrase alloc] initWithObjectDict:dict];
}

- (void)initPhraseVerify{
    NSString *mnemonics = [[CVSDKBridgingWallet shared] getMnemonic];
    NSArray *array = [mnemonics componentsSeparatedByString:@" "];
    _phrasesVerify = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++) {
        int order = i + 1;
        CVSDKPhrase *phrase = [self createPhrase:[array objectAtIndex:i] order:[NSNumber numberWithInt:order] position:nil show:@"false"];
        [_phrasesVerify addObject:phrase];
    }
    [self.collectionViewPhraseVerify reloadData];
    
    if([CVSDKUtils isScreenLandcape]){
        self.heightViewPhraseVerify.constant = 90;
        if([array count] == 24){
            self.heightViewPhraseVerify.constant = 170;
        }
    }else{
        self.heightViewPhraseVerify.constant = 170;
        if([array count] == 24){
            self.heightViewPhraseVerify.constant = 340;
        }
    }
    
}


- (void)initPhraseRandom{
    NSString *mnemonics = [[CVSDKBridgingWallet shared] getMnemonic];
    NSArray *array = [mnemonics componentsSeparatedByString:@" "];
    for (int i = 0; i < [array count]; i++) {
        int order = i + 1;
        CVSDKPhrase *phrase = [self createPhrase:[array objectAtIndex:i] order:[NSNumber numberWithInt:order] position:nil show:@"true"];
        if(i == 0){
            _phrasesRandomTmp = [NSArray arrayWithObject:phrase];
        }else{
            _phrasesRandomTmp = [_phrasesRandomTmp arrayByAddingObject:phrase];
        }
        
    }
    
    NSArray *random = [CVSDKUtils shuffleArray:_phrasesRandomTmp];
    _phrasesRandom = [[NSMutableArray alloc]initWithArray:random];
    [self.collectionViewPhraseRandom reloadData];
    
    if([CVSDKUtils isScreenLandcape]){
        self.heightViewPhraseRandom.constant = 90;
        if([array count] == 24){
            self.heightViewPhraseRandom.constant = 170;
        }
    }else{
        self.heightViewPhraseRandom.constant = 170;
        if([array count] == 24){
            self.heightViewPhraseRandom.constant = 340;
        }
    }
    
}



- (void)close:(id)sender {
    [self doClose];
}


- (void)doClose{
    [self.delegate viewDidCancel:self];
}



- (void)verify:(id)sender {
    NSString *xUserAddress  = [[CVSDKBridgingWallet shared] importWallet:[[CVSDKBridgingWallet shared] getMnemonic]];
    //NSString *signedMessage = [[CVSDKBridgingWeb3 shared] signMessage:@"ChainVerse"];
    NSString *signedMessage = [[CVSDKBridgingWeb3 shared] signPersonalMessage:@"ChainVerse"];
    [CVSDKUserDefault setXUserAddress:xUserAddress];
    [CVSDKUserDefault setXUserSignature:signedMessage];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CONNECT_SUCCESS object:self];
    [self doClose];
}
@end
