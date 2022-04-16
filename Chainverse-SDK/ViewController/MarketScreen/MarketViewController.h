//
//  MarketViewController.h
//  Chainverse-SDK
//
//  Created by pham nam on 07/03/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btnMyAsset;

@end

NS_ASSUME_NONNULL_END
