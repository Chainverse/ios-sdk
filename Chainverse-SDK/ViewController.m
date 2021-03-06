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
    //[[ChainverseSDK shared] showConnectWalletView];
    [[ChainverseSDK shared] connectWithChainverse];
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
    //[[ChainverseSDK shared] getDetailNFT:@"sdsdsd" tokenId:87867];
    [self presentViewController:object animated:YES completion:nil];
    //[[ChainverseSDK shared] signMessage:@"ChainVerse"];
    //[[ChainverseSDK shared] signTransaction:@"" gasPrice:@"" gasLimit:@"" toAddress:@"" amount:@"" chainID:@"" templateData:nil];
    //[[ChainverseSDK shared] signTransaction:@"" gasPrice:@"" gasLimit:<#(nonnull NSString *)#> toAddress:<#(nonnull NSString *)#> amount:<#(nonnull NSString *)#> chainID:<#(nonnull NSString *)#> templateData:<#(nonnull NSData *)#>]
    
    //[[ChainverseSDK shared] approveToken:@"0x672021e3c741910896cad6D6121446a328ba5634" amount:@"1000"];
    //[[ChainverseSDK shared] buyNFT:@"0x672021e3c741910896cad6D6121446a328ba5634" listingId:1000 price:@"100"];
    
    /*NSNumber *test = [NSNumber numberWithLong:364];
    [test integerValue];
    [[ChainverseSDK shared] approveNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:[test integerValue]];*/
}

@end
