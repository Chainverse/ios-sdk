//
//  MyAssetCollectionViewCell.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/03/2022.
//

#import "MyAssetCollectionViewCell.h"
#import "CVSDKTokenURI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NFT.h"
@interface MyAssetCollectionViewCell ()

@property (assign, nonatomic) BOOL alreadyLayout;


@end
@implementation MyAssetCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.alreadyLayout) {
        self.alreadyLayout = YES;
        [self setupUI];
    }

}

- (void)setupUI{
    
}

- (void)setupData:(id)item atIndexPath:(NSIndexPath *)indexPath{
    NFT *nft = (NFT *)item;
    self.lblNFT.text = [NSString stringWithFormat:@"%@ %@",nft.name,nft.token_id] ;
    
    [self.imageView setImageWithURL:[NSURL URLWithString: nft.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
