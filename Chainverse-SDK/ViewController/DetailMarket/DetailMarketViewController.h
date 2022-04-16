//
//  DetailMarketViewController.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/03/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailMarketViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *owner;
@property (weak, nonatomic) IBOutlet UITextView *des;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblTokenId;
@property (weak, nonatomic) IBOutlet UILabel *lblBlockchain;
@property (weak, nonatomic) IBOutlet UIButton *btnApprove;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
@property (weak, nonatomic) IBOutlet UIView *iconCurrency;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *viewPrice;
@property (weak, nonatomic) IBOutlet UIView *viewBuy;
@property (weak, nonatomic) IBOutlet UIView *viewSell;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewPriceHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnSell;
@property (weak, nonatomic) IBOutlet UIButton *btnPublish;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelSell;
@property (weak, nonatomic) IBOutlet UIView *viewSellCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnTransfer;

@property (nonatomic, strong) NSString *nft;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger tokenId;


@end

NS_ASSUME_NONNULL_END
