//
//  CVSDKSignTransactionView.h
//  Chainverse-SDK
//
//  Created by pham nam on 07/04/2022.
//

#import "CVSDKBaseView.h"
#import "CVSDKContractConfirmInput.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKContractConfirmView : CVSDKBaseView
- (instancetype)initView:(CVSDKContractConfirmInput *)input;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeadermarginTop;
@property (weak, nonatomic) IBOutlet UIButton *btnSign;
@property (weak, nonatomic) IBOutlet UIView *viewFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIView *viewFee;
@property (weak, nonatomic) IBOutlet UILabel *lblFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblTo;
@property (weak, nonatomic) IBOutlet UILabel *lblFee;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblContract;
@property (weak, nonatomic) IBOutlet UILabel *lblValue;
@property (weak, nonatomic) IBOutlet UILabel *lblAsset;
@property (weak, nonatomic) IBOutlet UILabel *lblHeadTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleTo;
@property (weak, nonatomic) IBOutlet UIView *viewAsset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewFrom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewFromMarginTop;

@end

NS_ASSUME_NONNULL_END
