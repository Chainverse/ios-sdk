//
//  CVSDKConnectWalletView.h
//  Chainverse-SDK
//
//  Created by pham nam on 21/07/2021.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKConnectWalletView : CVSDKBaseView
- (instancetype)initView;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnConnectChainverse;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end

NS_ASSUME_NONNULL_END
