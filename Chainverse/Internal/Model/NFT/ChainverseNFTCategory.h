//
//  CVTNFTCategories.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseNFTCategory

@end
@interface ChainverseNFTCategory : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger category_id;
@end

NS_ASSUME_NONNULL_END
