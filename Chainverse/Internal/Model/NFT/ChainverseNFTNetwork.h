//
//  CVTNFTNetwork.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseNFTNetwork

@end
@interface ChainverseNFTNetwork : JSONModel
@property (nonatomic, strong) NSString *network;
@property (nonatomic) NSInteger chain_id;
@property (nonatomic, strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
