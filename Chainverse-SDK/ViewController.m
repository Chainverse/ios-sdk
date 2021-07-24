//
//  ViewController.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "ViewController.h"
#import "ChainverseSDK.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnConnect addTarget:self action:@selector(handleConnect:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnTransfer addTarget:self action:@selector(handleTransfer:) forControlEvents:UIControlEventTouchUpInside];
    self.btnTransfer.hidden = TRUE;
    [self.btnChoose addTarget:self action:@selector(handleChoose:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnLogout addTarget:self action:@selector(handleLogout:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(receiveTestNotification:)
            name:@"SampleNotiAddress"
            object:nil];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
        NSString *address = [userInfo objectForKey:@"address"];
    self.lblAddress.text = address;
}

- (void)handleConnect:(id)sender {
    [[ChainverseSDK shared] connectTrust];
}


- (void)handleTransfer:(id)sender {
   
}

- (void)handleChoose:(id)sender {
    [[ChainverseSDK shared] showConnectWalletView];
}

- (void)handleLogout:(id)sender {
    [[ChainverseSDK shared] logout];
}
@end
