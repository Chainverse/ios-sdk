//
//  CVSDKWalletCreateView.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWalletExportView : CVSDKBaseView
- (instancetype)initView;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIButton *btnRecovery;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIView *viewAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnExportPrivateKey;
@property (weak, nonatomic) IBOutlet UIView *viewCopiedAddress;
@property (weak, nonatomic) IBOutlet UIView *viewPrivateKey;
@property (weak, nonatomic) IBOutlet UILabel *lblPrivateKey;
@property (weak, nonatomic) IBOutlet UIView *viewCopiedPrivateKey;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewCopiedPrivateKey;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewCopiedAddress;

@end

NS_ASSUME_NONNULL_END
