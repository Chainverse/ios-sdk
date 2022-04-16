//
//  CVTNFTDetail.h
//  Chainverse-SDK
//
//  Created by pham nam on 28/03/2022.
//

#import "JSONModel.h"
#import "ChainverseNFT.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CVSDKNFTDetail

@end
@interface CVSDKNFTDetail : JSONModel
@property(nonatomic, strong) ChainverseNFT *data;
@end

NS_ASSUME_NONNULL_END
