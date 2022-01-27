//
//  DemoTableViewCell.m
//  Chainverse-SDK
//
//  Created by tienpm on 26/01/2022.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

+ (NSString *)nibName {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWith:(NSDictionary *)item {
    titleLb.text = item[@"title"];
    descLb.text = item[@"description"];
}

@end
