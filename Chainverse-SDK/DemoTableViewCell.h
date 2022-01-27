//
//  DemoTableViewCell.h
//  Chainverse-SDK
//
//  Created by tienpm on 26/01/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel *titleLb;
    __weak IBOutlet UILabel *descLb;
}
+ (NSString *)nibName;
- (void)configCellWith:(NSDictionary *)item;

@end

NS_ASSUME_NONNULL_END
