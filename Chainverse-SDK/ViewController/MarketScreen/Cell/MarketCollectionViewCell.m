//
//  MarketCollectionViewCell.m
//  Chainverse-SDK
//
//  Created by pham nam on 08/03/2022.
//

#import "MarketCollectionViewCell.h"
#import "CVSDKTokenURI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NFT.h"
#import "InfoSell.h"
@interface MarketCollectionViewCell ()

@property (assign, nonatomic) BOOL alreadyLayout;


@end

@implementation MarketCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.alreadyLayout) {
        self.alreadyLayout = YES;
        [self setupUI];
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupUI{
    self.viewContainer.layer.cornerRadius = 10;
    self.viewContainer.layer.borderColor = [UIColor grayColor].CGColor;
    self.viewContainer.layer.borderWidth = 1.0f;
    self.btnBuy.layer.cornerRadius = 10;
}

- (void)setupData:(id)item atIndexPath:(NSIndexPath *)indexPath type:(NSString *)type{
    NFT *nft = (NFT *)item;
    self.lblName.text = [NSString stringWithFormat:@"%@ %@",nft.name,nft.token_id] ;
    
    //ChainverseNFTAuction *auction = NFT.auctions.firstObject;
    
    InfoSell *infoSell = nft.infoSell;
    self.lblPrice.text = [NSString stringWithFormat:@"%@",infoSell.price];
    
    Currency *currency = infoSell.currency_info;
    if([currency.symbol isEqualToString:@"tBNB"]){
        [self.iconSymbol setImage:[UIImage imageNamed:@"bnb.png"]];
    }else if([currency.symbol isEqualToString:@"USDT"]){
        [self.iconSymbol setImage:[UIImage imageNamed:@"usdt.png"]];
    }else if([currency.symbol isEqualToString:@"CVT"]){
        [self.iconSymbol setImage:[UIImage imageNamed:@"cvt.png"]];
    }
    
    /*NSArray<ChainverseNFTCategory> *categories = NFT.categories;
    for(ChainverseNFTCategory *category in categories){
        self.lblCategory.text = category.name;
    }*/
    
    [self.imageView setImageWithURL:[NSURL URLWithString: nft.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
}
@end
