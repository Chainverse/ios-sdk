//
//  CVTNFTData.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"
#import "ChainverseNFT.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CVSDKNFTData

@end
@interface CVSDKNFTData : JSONModel
@property (nonatomic, strong) NSArray<ChainverseNFT> *rows;
@property (nonatomic, strong) NSArray<ChainverseNFT> *data;
@property (nonatomic, strong) NSArray<ChainverseNFT> *items;
@end

NS_ASSUME_NONNULL_END
