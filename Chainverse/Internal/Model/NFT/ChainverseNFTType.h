//
//  CVTNFTType.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseNFTType

@end
@interface ChainverseNFTType : JSONModel
@property (nonatomic, strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
