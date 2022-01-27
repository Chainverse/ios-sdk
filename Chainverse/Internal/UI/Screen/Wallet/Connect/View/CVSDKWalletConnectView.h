//
//  CVSDKWalletCreateView.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWalletConnectView : CVSDKBaseView
- (instancetype)initView;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnImport;

@end

NS_ASSUME_NONNULL_END
