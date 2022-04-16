//
//  CVSDKWalletCreateView.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWalletImportView : CVSDKBaseView
- (instancetype)initView;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIButton *btnImport;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIView *viewInput;
@property (weak, nonatomic) IBOutlet UIButton *btnPaste;
@property (weak, nonatomic) IBOutlet UITextView *inputPhrase;
@property (weak, nonatomic) IBOutlet UILabel *viewError;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeadermarginTop;
@end

NS_ASSUME_NONNULL_END
