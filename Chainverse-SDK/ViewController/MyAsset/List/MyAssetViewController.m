//
//  MyAssetViewController.m
//  Chainverse-SDK
//
//  Created by pham nam on 11/03/2022.
//

#import "MyAssetViewController.h"
#import "MyAssetCollectionViewCell.h"
#import "ChainverseSDK.h"
#import "DetailMarketViewController.h"
@interface MyAssetViewController() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_myAssetItems;
    NSMutableArray<NFT> *_items;
}
@end

@implementation MyAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(receiveMyAssetNotification:)
            name:@"SampleMyAssetItem"
            object:nil];
    [[ChainverseSDK shared] getMyAsset];
}

- (void) receiveMyAssetNotification:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
    _items = [userInfo objectForKey:@"myAssetItems"];
    
    
    /*for(ChainverseNFT *itemx in _items){
        NSLog(@"nampv_nft %@",itemx.token_id);
        NSLog(@"nampv_nft_ownder %@",itemx.owner);
    }*/
    
    [self.collectionView reloadData];
    
    [self setupNFTImage];
}

- (void)initCollectionView{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyAssetCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyAssetCollectionViewCell"];
}

#pragma collection view
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_items count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (CGRectGetWidth(self.collectionView.frame) - 5 * 4)/2;
    
    return CGSizeMake(cellWidth, 200);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyAssetCollectionViewCell" forIndexPath:indexPath];
    [((MyAssetCollectionViewCell *)cell) setupData:[_items objectAtIndex:indexPath.row] atIndexPath:indexPath];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NFT *item =  _items[indexPath.row];
    //[[ChainverseSDK shared] sellNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347 price:@"10.5" currency:@"0x672021e3c741910896cad6D6121446a328ba5634"];
    //NSString *tx = [[ChainverseSDK shared] cancelSellNFT:1032];
    //NSLog(@"nampv_cancel %@",tx);
    
    //NSString *tx = [[ChainverseSDK shared] approveNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    //NSString *tx = [[ChainverseSDK shared] approveNFTForGame:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    //NSLog(@"nampv_approved_nft %@",tx);
    //NSString *tx = [[ChainverseSDK shared] approveToken:@"0x672021e3c741910896cad6D6121446a328ba5634" spender:@"0x2ccA92F66BeA2A7fA2119B75F3e5CB698C252564" amount:@"1000"];
    //NSLog(@"nampv_approved_token %@",tx);
    //BOOL isApproved = [[ChainverseSDK shared] isApproved:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    //BOOL isApproved = [[ChainverseSDK shared] isApproved:@"0x672021e3c741910896cad6D6121446a328ba5634" owner:@"0xFEAd320Bf517B4dd82b21374fD8bfA1Bb2c70f85" spender:@"0x2ccA92F66BeA2A7fA2119B75F3e5CB698C252564"];
    /*if(isApproved){
        NSLog(@"nampv_isApproved");
    }else{
        NSLog(@"nampv_isApproved_no");
    }*/
    //[[ChainverseSDK shared] publishNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    //[[ChainverseSDK shared] getNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    //NSString *tx = [[ChainverseSDK shared] transferItem:@"0x808CBa49319A95A84aD3f86b18FACB1Daf33eBc8" nft:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    //NSString *tx = [[ChainverseSDK shared] withdrawNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    //NSString *tx = [[ChainverseSDK shared] moveItemToGame:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    //NSLog(@"nampv_moveservice %@",tx);
    
    DetailMarketViewController * object = [[DetailMarketViewController alloc] init];
    object.nft = item.nft;
    object.tokenId = [item.token_id integerValue];
    object.type = @"myasset";
    [self presentViewController:object animated:YES completion:nil];
}

- (void)setupNFTImage{
    for(int  i = 0; i < _items.count; i++){
        
        NFT *itemMarket =  _items[i];
        [[ChainverseSDK shared] getNFT:itemMarket.nft tokenId:[itemMarket.token_id integerValue] complete:^(NFT *item){
            itemMarket.image = item.image;
            itemMarket.name = item.name;
            [self.collectionView reloadData];
        }];
        
    }
    
}


@end
