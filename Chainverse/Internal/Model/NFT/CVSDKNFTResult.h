//
//  CVTNFTResult.h
//  Chainverse-SDK
//
//  Created by pham nam on 25/03/2022.
//

#import "JSONModel.h"
#import "CVSDKNFTData.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CVSDKNFTResult

@end

@interface CVSDKNFTResult : JSONModel
@property(nonatomic, strong) CVSDKNFTData *data;
@end

NS_ASSUME_NONNULL_END
