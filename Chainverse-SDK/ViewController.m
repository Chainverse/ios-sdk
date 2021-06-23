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
    [self.btnChoose addTarget:self action:@selector(handleChoose:) forControlEvents:UIControlEventTouchUpInside];
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
    [[ChainverseSDK shared] transferTrust:@"c60"
                                       to:@"0x728B02377230b5df73Aa4E3192E89b6090DD7312"
                                   amount:@"0.01"
                                 feePrice:@"2112000000"
                                 feeLimit:@"21000"];
}

- (void)handleChoose:(id)sender {
    [[ChainverseSDK shared] chooseWL];
}
@end
