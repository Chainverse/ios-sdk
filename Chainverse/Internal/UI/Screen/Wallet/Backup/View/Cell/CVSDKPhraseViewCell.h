//
//  CVSDKPhraseViewCell.h
//  Chainverse-SDK
//
//  Created by pham nam on 01/12/2021.
//

#import <UIKit/UIKit.h>
#import "CVSDKBaseCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKPhraseViewCell : CVSDKBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblBody;
- (void)setupData:(id)item atIndexPath:(NSIndexPath *)indexPath type:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
