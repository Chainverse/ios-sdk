//
//  TestScreenView.h
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestScreenView : CVSDKBaseView
- (instancetype)initView;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end

NS_ASSUME_NONNULL_END
