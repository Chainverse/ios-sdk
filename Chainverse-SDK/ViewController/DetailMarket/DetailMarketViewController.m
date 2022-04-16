//
//  DetailMarketViewController.m
//  Chainverse-SDK
//
//  Created by pham nam on 23/03/2022.
//

#import "DetailMarketViewController.h"
#import "ChainverseSDK.h"
#import "CVSDKTokenURI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ChainverseTokenSupport.h"
#import "ChainverseNFT.h" 
@interface DetailMarketViewController (){
    NSString *_price;
    NSString *_nft;
    NSInteger _listingId;
    ChainverseNFTCurrency *_currency;
    NSString *_currencyLabel;
}

@end

@implementation DetailMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(didGetDetailItem:)
            name:@"didGetDetailItem"
            object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(didTransact:)
            name:@"didTransact"
            object:nil];
    
    [[ChainverseSDK shared] getDetailNFT:self.nft tokenId:self.tokenId];
    
    [[ChainverseSDK shared] getNFT:self.nft tokenId:self.tokenId complete:^(ChainverseNFT *item){
        [self.imageView setImageWithURL:[NSURL URLWithString: item.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        self.des.text = item.description;
        
        if([self.type isEqualToString:@"market"]){
            self.owner.text = [NSString stringWithFormat:@"Owner by %@", item.owner];
        }
        
    }];
    
    
    
    if([self.type isEqualToString:@"market"]){
        self.viewPrice.hidden = NO;
        self.viewBuy.hidden = NO;
        self.viewSell.hidden = YES;
        self.viewSellCancel.hidden = YES;
    }else if([self.type isEqualToString:@"myasset"]){
        self.viewPrice.hidden = YES;
        self.viewBuy.hidden = YES;
        self.viewSell.hidden = NO;
        [self.viewBuy layoutIfNeeded];
        [self.viewPrice layoutIfNeeded];
        self.viewSellCancel.hidden = NO;
    }
    
    self.btnPublish.hidden = YES;
    self.btnCancelSell.hidden = YES;
}

- (void) didTransact:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSDictionary *tmp = [userInfo objectForKey:@"didTransact"];
    NSString *tx = [tmp objectForKey:@"tx"];
    NSNumber *func = [tmp objectForKey:@"function"];
    int function = [func intValue];
    /*
     approveToken = 1,
     approveNFT = 2,
     buyNFT = 3,
     bidNFT = 4,
     sellNFT = 5,
     cancelSell = 6,
     withdrawItem = 7,
     moveService = 8,
     transferItem = 9*/
    if(function == 3){
        if(![tx isEqualToString:@"0x"]){
            UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Complete checkout"
                                             message: [NSString stringWithFormat:@"Transaction Successful! %@",tx] preferredStyle: UIAlertControllerStyleAlert
                                            ];
            UIAlertAction * action = [UIAlertAction actionWithTitle: @ "View Transaction"
                                        style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://testnet.bscscan.com/tx/%@",tx]];
                                        if (@available(iOS 10.0, *)){
                                            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                                  [[UIApplication sharedApplication]
                                                              openURL:url options:@{}
                                                              completionHandler:nil];
                                              }
                                        } else {
                                            [[UIApplication sharedApplication] openURL:url];
                                        }
                                        }
                                       ];
            [alertvc addAction: action];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alertvc addAction:cancel];
            
            [self presentViewController: alertvc animated: true completion: nil];
        }else{
            UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Alert"
                                                                              message: [NSString stringWithFormat:@"Transaction Error! %@",tx] preferredStyle: UIAlertControllerStyleAlert];
        
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alertvc addAction:cancel];
            
            [self presentViewController: alertvc animated: true completion: nil];
        }
        
    }else if (function == 5){
        
        UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Complete Sell"
                                         message: [NSString stringWithFormat:@"Transaction Successful! %@",tx] preferredStyle: UIAlertControllerStyleAlert
                                        ];
        UIAlertAction * action = [UIAlertAction actionWithTitle: @ "View Transaction"
                                    style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://testnet.bscscan.com/tx/%@",tx]];
                                    if (@available(iOS 10.0, *)){
                                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                              [[UIApplication sharedApplication]
                                                          openURL:url options:@{}
                                                          completionHandler:nil];
                                          }
                                    } else {
                                        [[UIApplication sharedApplication] openURL:url];
                                    }
                                    }
                                   ];
        [alertvc addAction: action];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
        [alertvc addAction:cancel];
        
        [self presentViewController: alertvc animated: true completion: nil];
        
        self.viewSell.hidden = YES;
        self.viewSellCancel.hidden = NO;
        self.btnCancelSell.hidden = NO;
        self.btnPublish.hidden = NO;
        
        [[ChainverseSDK shared] getNFT:self.nft tokenId:self.tokenId complete:^(ChainverseNFT *item){
            [self.imageView setImageWithURL:[NSURL URLWithString: item.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            self.des.text = item.description;
            
            if([self.type isEqualToString:@"market"]){
                self.owner.text = [NSString stringWithFormat:@"Owner by %@", item.owner];
            }
            
        }];
        
    }else if (function == 6){
        self.viewSell.hidden = NO;
        self.btnSell.hidden = NO;
        self.btnTransfer.hidden = NO;
        self.viewSellCancel.hidden = YES;
        self.btnCancelSell.hidden = YES;
        self.btnPublish.hidden = YES;
    }else if (function == 9){
        UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Transfer your item"
                                         message: [NSString stringWithFormat:@"Transaction Successful! %@",tx] preferredStyle: UIAlertControllerStyleAlert
                                        ];
        UIAlertAction * action = [UIAlertAction actionWithTitle: @ "View Transaction"
                                    style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://testnet.bscscan.com/tx/%@",tx]];
                                    if (@available(iOS 10.0, *)){
                                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                              [[UIApplication sharedApplication]
                                                          openURL:url options:@{}
                                                          completionHandler:nil];
                                          }
                                    } else {
                                        [[UIApplication sharedApplication] openURL:url];
                                    }
                                    }
                                   ];
        [alertvc addAction: action];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
        [alertvc addAction:cancel];
        
        [self presentViewController: alertvc animated: true completion: nil];
    }
    
}


- (void) didGetDetailItem:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
    ChainverseNFT *NFT = [userInfo objectForKey:@"GetDetailNFT"];
   
    _nft = NFT.nft;
    
    self.name.text = [NSString stringWithFormat:@"%@ %@",NFT.name,NFT.token_id] ;
    self.lblAddress.text = [NSString stringWithFormat:@"Contract Address: %@", NFT.nft];
    self.lblTokenId.text = [NSString stringWithFormat:@"Token ID: %@", NFT.token_id];;
    self.owner.text = [NSString stringWithFormat:@"Owner by %@", NFT.owner];
    
    ChainverseNFTAuction *auction = NFT.auctions.firstObject;
    self.lblPrice.text = [NSString stringWithFormat:@"%@",auction.price];
    _price = auction.price;
    _listingId = [auction.listing_id integerValue];
    NSLog(@"listing_id %ld",_listingId);
    if(_listingId > 0){
        self.btnPublish.hidden = NO;
        
        self.btnCancelSell.hidden = NO;
        self.btnSell.hidden = YES;
        self.btnTransfer.hidden = YES;
    }else{
        self.btnPublish.hidden = YES;
        
        self.btnCancelSell.hidden = YES;
        self.btnSell.hidden = NO;
        self.btnTransfer.hidden = NO;
    }
    
    _currency = auction.currency_info;
    _currencyLabel = @"CVT";
    if([_currency.symbol isEqualToString:@"tBNB"]){
        [self.icon setImage:[UIImage imageNamed:@"bnb.png"]];
        self.btnApprove.hidden = YES;
        _currencyLabel = @"BNB";
    }else if([_currency.symbol isEqualToString:@"USDT"]){
        self.btnApprove.hidden = NO;
        [self.icon setImage:[UIImage imageNamed:@"usdt.png"]];
        _currencyLabel = @"USDT";
    }else if([_currency.symbol isEqualToString:@"CVT"]){
        self.btnApprove.hidden = NO;
        [self.icon setImage:[UIImage imageNamed:@"cvt.png"]];
        _currencyLabel = @"CVT";
    }
    
    NSArray<ChainverseNFTCategory> *categories = NFT.categories;
    for(ChainverseNFTCategory *category in categories){
        self.category.text = category.name;
    }
    
    [self.btnApprove setTitle:[NSString stringWithFormat:@"Approve %@",_currencyLabel] forState:UIControlStateNormal];
    

    ChainverseNFTNetwork *network = NFT.network_info;
    self.lblBlockchain.text = network.name;
    [self.imageView setImageWithURL:[NSURL URLWithString: NFT.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [self checkApprove];
    [self.btnApprove addTarget:self action:@selector(doApprove:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnBuy addTarget:self action:@selector(doBuy:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Sell type
    
    
    [self.btnSell addTarget:self action:@selector(doSell:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnPublish addTarget:self action:@selector(doPublish:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancelSell addTarget:self action:@selector(doCancelSell:) forControlEvents:UIControlEventTouchUpInside];
    
    if([NFT.status isEqualToString:@"PUBLISH"]){
        self.btnPublish.hidden = YES;
        
        /*if([self.type isEqualToString:@"myasset"]){
            self.btnTransfer.hidden = NO;
        }*/
    }else if([NFT.status isEqualToString:@"PRE_PUBLISH"]){
        //self.btnPublish.hidden = NO;
        
        /*if([self.type isEqualToString:@"myasset"]){
            self.btnTransfer.hidden = NO;
        }*/
        
    }
    
    [self.btnTransfer addTarget:self action:@selector(doTransfer:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)doTransfer:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Transfer your item"
                                                                                      message: @"RECEIVER ADDRESS"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Receiver address";
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSArray * textfields = alertController.textFields;
            UITextField * namefield = textfields[0];
            
            BOOL isAddress = [[ChainverseSDK shared] isAddress:namefield.text];
            if(isAddress){
                NSString *tx = [[ChainverseSDK shared] transferItem:namefield.text nft:_nft tokenId:self.tokenId];
                NSLog(@"nampv_transfer%@",tx);
            }else{
                UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Alert"
                                                 message: @"Address is Invalid" preferredStyle: UIAlertControllerStyleAlert
                                                ];
               
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alertvc addAction:cancel];
                
                [self presentViewController: alertvc animated: true completion: nil];
            }
            

        }]];
        [self presentViewController:alertController animated:YES completion:nil];
}



- (void)doCancelSell:(id)sender {
    [[ChainverseSDK shared] cancelSellNFT:_listingId];
}

- (void)doPublish:(id)sender {
    [[ChainverseSDK shared] publishNFT:_nft tokenId:self.tokenId complete:^(BOOL isPublished){
        self.btnPublish.hidden = YES;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Publish" message:@"Publish successfully!" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)doSellApprove:(id)sender {
    
    
}

- (void)doSell:(id)sender {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Approve" message:@"I agree to Chainverse's Terms of Service" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Approve" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *tx = [[ChainverseSDK shared] approveNFT:_nft tokenId:self.tokenId];
        
        NSString *message = [NSString stringWithFormat:@"Bạn muốn bán %@",_nft];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Sell Action"
                                                                                          message: message
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"Input amount";
                textField.textColor = [UIColor blueColor];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
            }];
        
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"Input currency (CVT, USDT, tBNB)";
                textField.textColor = [UIColor blueColor];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleRoundedRect;
            }];
            
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"SELL" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSArray * textfields = alertController.textFields;
                UITextField * price = textfields[0];
                UITextField * currency = textfields[1];
                NSString *cr = TOKEN_CVT;
                if([currency.text isEqualToString:@"CVT"]){
                    cr = TOKEN_CVT;
                }else if([currency.text isEqualToString:@"USDT"]){
                    cr = TOKEN_USDT;
                }else if([currency.text isEqualToString:@"tBNB"]){
                    cr = TOKEN_BNB;
                }
                
                NSLog(@"nampv_currency %@",cr);
                [[ChainverseSDK shared] sellNFT:_nft tokenId:self.tokenId price:price.text currency:cr];
                
            }]];
        
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
        
            [self presentViewController:alertController animated:YES completion:nil];
        
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *)getCurrency{
    NSString *currency = TOKEN_CVT;
    if([_currency.symbol isEqualToString:@"tBNB"]){
        currency = TOKEN_BNB;
    }else if([_currency.symbol isEqualToString:@"USDT"]){
        currency = TOKEN_USDT;
    }else if([_currency.symbol isEqualToString:@"CVT"]){
        currency = TOKEN_CVT;
    }
    return currency;
}
- (void)doApprove:(id)sender {
    NSString *tx = [[ChainverseSDK shared] approveToken:[self getCurrency] amount:_price];
    NSLog(@"nampv_appsampe_approve %@",tx);
    [self checkApprove];
}

- (NSString *)getBalance{
    NSString *balance = [[ChainverseSDK shared] getBalance:[self getCurrency]];
    if([_currency.symbol isEqualToString:@"tBNB"]){
        balance = [[ChainverseSDK shared] getBalance];
    }else if([_currency.symbol isEqualToString:@"USDT"]){
        balance = [[ChainverseSDK shared] getBalance:[self getCurrency]];
    }else if([_currency.symbol isEqualToString:@"CVT"]){
        balance = [[ChainverseSDK shared] getBalance:[self getCurrency]];
    }
    return balance;
}

- (void)doBuy:(id)sender {
    NSString *balance = [self getBalance];
    float ba = [balance  floatValue];

    if(ba > [_price floatValue]){
        NSLog(@"nampv_appsampe_buy %@",_price);
        [[ChainverseSDK shared] buyNFT:[self getCurrency] listingId:_listingId price:_price];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:[NSString stringWithFormat:@"Bạn không đủ %@ vui lòng nạp thêm!",_currencyLabel] preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    //NSString *tx = [[ChainverseSDK shared] buyNFT:[self getCurrency] listingId:222 price:@"0.1"];
    //NSLog(@"nampv_appsampe_buy %@",tx);
}

- (void)checkApprove{
    ChainverseUser *info = [[ChainverseSDK shared] getUser];
    NSString * allowence = [[ChainverseSDK shared] isApproved:TOKEN_USDT owner:info.address spender:@"0x2ccA92F66BeA2A7fA2119B75F3e5CB698C252564"];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:allowence];
    
}


@end
