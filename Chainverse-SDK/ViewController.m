//
//  ViewController.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "ViewController.h"
#import "ChainverseSDK.h"
#import "MarketViewController.h"
#import "ChainverseTokenSupport.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnConnect addTarget:self action:@selector(handleConnect:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMarket addTarget:self action:@selector(handleMarket:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnWalletInfo addTarget:self action:@selector(handleWalletInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnLogout addTarget:self action:@selector(handleLogout:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(didConnectSuccess:)
            name:@"didConnectSuccess"
            object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(didLogout:)
            name:@"didLogout"
            object:nil];
    
    [self checkUI];
    
}

- (void)checkUI{
    if([[ChainverseSDK shared] isUserConnected]){
        self.btnMarket.hidden = NO;
        self.btnLogout.hidden = NO;
        self.btnWalletInfo.hidden = NO;
        self.viewBalance.hidden = NO;
        self.btnConnect.hidden = YES;
    }else{
        self.btnMarket.hidden = YES;
        self.btnLogout.hidden = YES;
        self.btnWalletInfo.hidden = YES;
        self.viewBalance.hidden = YES;
        self.btnConnect.hidden = NO;
    }
}

- (void) didLogout:(NSNotification *) notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *address = [userInfo objectForKey:@"address"];
    NSLog(@"ChainverseSDKCallback_didLogout1 %@",address);
    [self checkUI];
}

- (void) didConnectSuccess:(NSNotification *) notification
{
    [self checkUI];
    NSDictionary *userInfo = notification.userInfo;
        NSString *address = [userInfo objectForKey:@"address"];
    self.lblAddress.text = address;
    self.lblBalanceNativeCoin.text = [[ChainverseSDK shared] getBalance];
    self.lblBalanceUsdt.text = [NSString stringWithFormat:@"USD: %@",[[ChainverseSDK shared] getBalance:TOKEN_USDT]];
    self.lblBalanceCVT.text = [NSString stringWithFormat:@"CVT: %@",[[ChainverseSDK shared] getBalance:TOKEN_CVT]] ;
}

- (void)handleConnect:(id)sender {
    [[ChainverseSDK shared] showConnectWalletView];
    //[[ChainverseSDK shared] connectWithChainverse];
}

- (void)handleWalletInfo:(id)sender {
    [[ChainverseSDK shared] showWalletInfoView];
    //[[ChainverseSDK shared] signMessage:@"ChainVerse"];
}
- (void)handleLogout:(id)sender {
    [[ChainverseSDK shared] logout];
}

- (void)handleMarket:(id)sender {
    MarketViewController * object = [[MarketViewController alloc] init];
    [self presentViewController:object animated:YES completion:nil];
    //[[ChainverseSDK shared] signMessage:@"ChainVerse"];
    //[[ChainverseSDK shared] signTransaction:@"" gasPrice:@"" gasLimit:@"" toAddress:@"" amount:@"" chainID:@"" templateData:nil];
    
}
@end
