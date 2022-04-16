//
//  MyAssetCollectionViewCell.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/03/2022.
//

#import "MyAssetCollectionViewCell.h"
#import "CVSDKTokenURI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ChainverseNFT.h"
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
    ChainverseNFT *NFT = (ChainverseNFT *)item;
    self.lblNFT.text = [NSString stringWithFormat:@"%@ %@",NFT.name,NFT.token_id] ;
    
    [self.imageView setImageWithURL:[NSURL URLWithString: NFT.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
