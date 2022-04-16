//
//  CVSDKWalletCreateView.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWalletBackupView : CVSDKBaseView
- (instancetype)initView:(NSString *)type;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIView *viewPhrase;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewPhrase;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewPhrase;
@property (weak, nonatomic) IBOutlet UIButton *btnCopyPhrase;
@property (weak, nonatomic) IBOutlet UIButton *btnCopied;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeadermarginTop;

@end

NS_ASSUME_NONNULL_END
