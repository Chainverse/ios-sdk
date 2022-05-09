//
//  Type.h
//  Chainverse-SDK
//
//  Created by pham nam on 06/05/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol Type

@end
@interface Type : JSONModel
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
