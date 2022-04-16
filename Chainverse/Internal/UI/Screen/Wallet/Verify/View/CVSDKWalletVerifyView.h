//
//  CVSDKWalletCreateView.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWalletVerifyView : CVSDKBaseView
- (instancetype)initView;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIView *viewPhraseVerify;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewPhraseVerify;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewPhraseVerify;
@property (weak, nonatomic) IBOutlet UIButton *btnVerify;
@property (weak, nonatomic) IBOutlet UIView *viewPhraseRandom;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewPhraseRandom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewPhraseRandom;
@property (weak, nonatomic) IBOutlet UIView *viewMessageError;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeadermarginTop;

@end

NS_ASSUME_NONNULL_END
