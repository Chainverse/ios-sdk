//
//  ViewController.h
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblBalanceNativeCoin;
@property (weak, nonatomic) IBOutlet UILabel *lblBalanceUsdt;
@property (weak, nonatomic) IBOutlet UILabel *lblBalanceCVT;
@property (weak, nonatomic) IBOutlet UIButton *btnConnect;
@property (weak, nonatomic) IBOutlet UIButton *btnMarket;
@property (weak, nonatomic) IBOutlet UIButton *btnWalletInfo;
@property (weak, nonatomic) IBOutlet UIView *viewBalance;

@property (weak, nonatomic) IBOutlet UIButton *btnLogout;


@end

