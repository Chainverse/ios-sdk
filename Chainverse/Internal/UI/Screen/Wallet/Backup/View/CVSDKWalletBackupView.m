//
//  CVSDKWalletCreateView.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWalletBackupView.h"
#import "CVSDKUtils.h"
#import "CVSDKBaseResource.h"
#import "CVSDKWallet.h"
#import "CVSDKUserDefault.h"
#import "CVSDKPhrase.h"
#import "CVSDKPhraseViewCell.h"
#import "CVSDKWalletVerifyScreen.h"
@interface CVSDKWalletBackupView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    BOOL isLayoutSubview;
    NSMutableArray *_phrases;
    NSString *_type;
}
@end
@implementation CVSDKWalletBackupView

- (instancetype)initView:(NSString *)type{
    if(self = [super initViewFromNib]){
        _type = type;
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(!isLayoutSubview){
        isLayoutSubview = YES;
        [self initUI];
        [self initCollectionView];
        [self initPhrase];
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
    self.btnNext.hidden = NO;
    if([_type isEqualToString:@"recovery"]){
        self.btnNext.hidden = YES;
    }
    self.btnNext.layer.cornerRadius = 10;
    [self.btnNext addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    self.btnNext.enabled = true;
    self.btnNext.backgroundColor = [CVSDKUtils colorWithHexString:@"#077DC5"];
    
    self.viewPhrase.layer.cornerRadius = 10;
    self.viewPhrase.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
    self.viewPhrase.layer.borderWidth = 1.0f;
    
    self.btnCopied.hidden = YES;
    self.btnCopyPhrase.hidden = NO;
    [self.btnCopyPhrase addTarget:self action:@selector(copyPhrase:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)copyPhrase:(id)sender {
    self.btnCopied.hidden = NO;
    self.btnCopyPhrase.hidden = YES;
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [CVSDKUserDefault getMnemonic];
}

- (void)initCollectionView{
    self.collectionViewPhrase.dataSource = self;
    self.collectionViewPhrase.delegate = self;
    [self.collectionViewPhrase registerNib:[CVSDKPhraseViewCell nib] forCellWithReuseIdentifier:[CVSDKPhraseViewCell nibName]];
}

#pragma collection view
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_phrases count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (CGRectGetWidth(self.collectionViewPhrase.frame) - 5 * 4)/3;
    
    return CGSizeMake(cellWidth, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CVSDKPhraseViewCell nibName] forIndexPath:indexPath];
    [((CVSDKPhraseViewCell *)cell) setupData:[_phrases objectAtIndex:indexPath.row] atIndexPath:indexPath type:@"default"];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
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

- (void)initPhrase{
    NSString *mnemonics = [CVSDKUserDefault getMnemonic];
    NSArray *array = [mnemonics componentsSeparatedByString:@" "];
    _phrases = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++) {
        int order = i + 1;
        CVSDKPhrase *phrase = [self createPhrase:[array objectAtIndex:i] order:[NSNumber numberWithInt:order] position:nil show:@"true"];
        [_phrases addObject:phrase];
    }
    [self.collectionViewPhrase reloadData];
    self.heightViewPhrase.constant = 170;
    if([array count] == 24){
        self.heightViewPhrase.constant = 340;
    }
    
}

- (void)close:(id)sender {
    [self doClose];
}

- (void)doClose{
    [self.delegate viewDidCancel:self];
}



- (void)next:(id)sender {
    [CVSDKWalletVerifyScreen open];
    [self doClose];
}
@end
