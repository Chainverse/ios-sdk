//
//  MyAssetCollectionViewCell.h
//  Chainverse-SDK
//
//  Created by pham nam on 11/03/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAssetCollectionViewCell : UICollectionViewCell
- (void)setupData:(id)item atIndexPath:(NSIndexPath *)indexPath;
@property (weak, nonatomic) IBOutlet UILabel *lblNFT;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END
