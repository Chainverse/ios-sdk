//
//  CVSDKContractCallModel.h
//  Chainverse-SDK
//
//  Created by pham nam on 13/04/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CVSDKContractCallModel

@end
@interface CVSDKContractCallModel : JSONModel
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *contract;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableDictionary *params;
@end

NS_ASSUME_NONNULL_END
