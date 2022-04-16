//
//  MarketCollectionViewCell.h
//  Chainverse-SDK
//
//  Created by pham nam on 08/03/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketCollectionViewCell : UICollectionViewCell
- (void)setupData:(id)item atIndexPath:(NSIndexPath *)indexPath type:(NSString *)type;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
@property (weak, nonatomic) IBOutlet UIImageView *iconSymbol;

@end

NS_ASSUME_NONNULL_END
