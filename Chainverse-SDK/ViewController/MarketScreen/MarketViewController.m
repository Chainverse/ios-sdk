//
//  MarketViewController.m
//  Chainverse-SDK
//
//  Created by pham nam on 07/03/2022.
//

#import "MarketViewController.h"
#import "ChainverseSDK.h"
#import "MarketCollectionViewCell.h"
#import "CVSDKTokenURI.h"
#import "MyAssetViewController.h"
#import "DetailMarketViewController.h"
#import "ChainverseTokenSupport.h"
@interface MarketViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_marketItems;
    NSArray<ChainverseNFT> *_items;
}
@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(receiveNotificationMarketItem:)
            name:@"SampleMarketItem"
            object:nil];
    
    [[ChainverseSDK shared] getListItemOnMarket:0 pageSize:20];
    
    [self.btnMyAsset addTarget:self action:@selector(myAsset:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)myAsset:(id)sender {
    MyAssetViewController * object = [[MyAssetViewController alloc] init];
    [self presentViewController:object animated:YES completion:nil];
}



- (void) receiveNotificationMarketItem:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
    _items = [userInfo objectForKey:@"marketItems"];
    
    NSLog(@"didGetListItemMarket %@",_items);
    for(ChainverseNFT *itemx in _items){
        
        NSArray<ChainverseNFTAuction> *autions = itemx.auctions;
        for(ChainverseNFTAuction *auction in autions){
            NSLog(@"nampv_test %ld",auction.listing_id);
        }
        
        /*NSArray<ChainverseNFTCategory> *categories = itemx.categories;
        for(ChainverseNFTCategory *category in categories){
            NSLog(@"nampv_test_category %@",category.name);
        }*/
    }
    
    //_marketItems = items;
    [self.collectionView reloadData];
    [self setupNFTImage];
}

- (void)initCollectionView{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MarketCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MarketCollectionViewCell"];
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
    
    return CGSizeMake(cellWidth, 280);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MarketCollectionViewCell" forIndexPath:indexPath];
    [((MarketCollectionViewCell *)cell) setupData:[_items objectAtIndex:indexPath.row] atIndexPath:indexPath type:@"default"];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ChainverseNFT *marketItem =  _items[indexPath.row];
    
    //NSString *tx = [[ChainverseSDK shared] approveToken:@"0x672021e3c741910896cad6D6121446a328ba5634" spender:@"0x2ccA92F66BeA2A7fA2119B75F3e5CB698C252564" amount:@"1000"];
    //NSLog(@"nampv_approve_token %@",tx);
    //[[ChainverseSDK shared] buyNFT:currencyInfo.currency listingId:item.listing_id price:item.price];
    //[[ChainverseSDK shared] bidNFT:@"0x672021e3c741910896cad6D6121446a328ba5634" listingId:985 price:@"59"];
    
    //NSString *tx = [[ChainverseSDK shared] getBalance:@"0x337610d27c682E347C9cD60BD4b3b107C9d34dDd"];
    //NSLog(@"nampv_balence_token %@",tx);
    //[[ChainverseSDK shared] getDetailNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:347];
    
    
    DetailMarketViewController * object = [[DetailMarketViewController alloc] init];
    object.nft = marketItem.nft;
    object.tokenId = [marketItem.token_id integerValue];
    object.type = @"market";
    [self presentViewController:object animated:YES completion:nil];
    
    //[[ChainverseSDK shared] approveNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:222];
    /*BOOL isApproved = [[ChainverseSDK shared] isApproved:@"0x2bB0966B95Bf340C76a10b4D2e6364Da5A303F15" tokenId:4773];
    
    if(isApproved){
        NSLog(@"nampv_isApproved");
    }else{
        NSLog(@"nampv_isApproved_no");
    }*/
    
    //[[ChainverseSDK shared] sellNFT:@"0x7eAdaF22D3a4C10E0bA1aC692654b80954084bdD" tokenId:222 price:@"100" currency:TOKEN_CVT];
    
    //NSString *tx = [[ChainverseSDK shared] cancelSellNFT:1032];
}

- (void)setupNFTImage{
    for(int  i = 0; i < _items.count; i++){
        ChainverseNFT *itemMarket =  _items[i];
        [[ChainverseSDK shared] getNFT:itemMarket.nft tokenId:[itemMarket.token_id integerValue] complete:^(ChainverseNFT *item){
            itemMarket.image = item.image;
            [self.collectionView reloadData];
        }];
        
    }
    
}




@end
