//
//  ViewController.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/06/2021.
//

#import "ViewController.h"
#import "ChainverseSDK.h"
#import "DemoTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *items;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chainverse SDK for iOS";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(receiveTestNotification:)
            name:@"SampleNotiAddress"
            object:nil];

    items = [[NSMutableArray alloc] initWithObjects:
             @{@"title":@"Connect Wallet", @"description":@"Show Connect wallet page", @"scheme": @"connect_wallet", @"value": @0},
             @{@"title":@"Wallet", @"description":@"Show your wallet info page", @"scheme": @"wallet_info", @"value":@1},
             @{@"title":@"Get Items", @"description":@"Get list items", @"sheme": @"list_items", @"value": @2},
             @{@"title":@"Logout", @"description":@"", @"scheme": @"logout", @"value": @3},
             nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:[DemoTableViewCell nibName]
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:[DemoTableViewCell nibName]];
    [self.tableView reloadData];
    
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
        NSString *address = [userInfo objectForKey:@"address"];
    self.lblAddress.text = address;
}

- (void)handleTransfer:(id)sender {
    [[ChainverseSDK shared] testPurchase];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[DemoTableViewCell nibName]];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DemoTableViewCell nibName]];
    }
    if ([cell isKindOfClass:[DemoTableViewCell class]]) {
        DemoTableViewCell *demoCell = (DemoTableViewCell *)cell;
        [demoCell configCellWith:items[indexPath.row]];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *selectedItem = items[indexPath.row];
    int selectedItemValue = [selectedItem[@"value"] intValue];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    switch (selectedItemValue) {
        case 0:
            /// Connect wallet
            [[ChainverseSDK shared] showConnectWalletView];
            break;
            
        case 1:
            /// Show wallet info
            [[ChainverseSDK shared] showWalletInfoView];
            break;
            
        case 2:
            /// Get list item
            [[ChainverseSDK shared] getItems];
            break;
            
        case 3:
            /// Logout
            [[ChainverseSDK shared] logout];
            break;
            
        default:
            break;
    }
}

@end



