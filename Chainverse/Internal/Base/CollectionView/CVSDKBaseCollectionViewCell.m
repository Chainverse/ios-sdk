//
//  CVSDKBaseCollectionViewCell.m
//  Chainverse-SDK
//
//  Created by pham nam on 01/12/2021.
//

#import "CVSDKBaseCollectionViewCell.h"
#import "CVSDKBaseResource.h"
@implementation CVSDKBaseCollectionViewCell
+ (UINib *)nib{
    return [UINib nibWithNibName:[self nibName] bundle:[CVSDKBaseResource getBundle]];
}

+ (NSString *)nibName{
    return NSStringFromClass([self class]);
}

@end
