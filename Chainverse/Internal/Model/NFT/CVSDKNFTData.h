//
//  CVTNFTData.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"
#import "NFT.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CVSDKNFTData

@end
@interface CVSDKNFTData : JSONModel
@property (nonatomic, strong) NSArray<NFT> *rows;
@property (nonatomic, strong) NSArray<NFT> *data;
@property (nonatomic, strong) NSArray<NFT> *items;
@end

NS_ASSUME_NONNULL_END
