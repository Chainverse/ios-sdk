//
//  CVSDKWalletCreateView.h
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVSDKWalletCreateView : CVSDKBaseView
- (instancetype)initView;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIView *view12Words;
@property (weak, nonatomic) IBOutlet UIView *view24Words;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btn12Words;
@property (weak, nonatomic) IBOutlet UIButton *btn24Words;
@property (weak, nonatomic) IBOutlet UIButton *btnTerm;
@end

NS_ASSUME_NONNULL_END
