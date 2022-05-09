//
//  CVSDKGameServiceData.h
//  Chainverse-SDK
//
//  Created by pham nam on 05/05/2022.
//

#import <Chainverse/Chainverse.h>
#import "ChainverseGameService.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CVSDKGameServiceData

@end
@interface CVSDKGameServiceData : JSONModel
@property(nonatomic, strong) ChainverseGameService *data;
@end

NS_ASSUME_NONNULL_END
