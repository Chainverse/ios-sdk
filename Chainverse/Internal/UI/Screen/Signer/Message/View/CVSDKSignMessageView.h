//
//  CVSDKSignerView.h
//  Chainverse-SDK
//
//  Created by pham nam on 04/03/2022.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKSignMessageView : CVSDKBaseView
- (instancetype)initView:(NSMutableDictionary *)input;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeadermarginTop;
@property (weak, nonatomic) IBOutlet UITextField *tfMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnSign;
@property (weak, nonatomic) IBOutlet UILabel *lblWallet;
@property (weak, nonatomic) IBOutlet UIView *viewFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end

NS_ASSUME_NONNULL_END
