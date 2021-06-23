//
//  CVSDKChooseWLView.h
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "CVSDKBaseViewDialog.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKChooseWLView : CVSDKBaseView
- (instancetype)initView;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *btnNewScreen;

@end

NS_ASSUME_NONNULL_END
