//
//  CVSDKContractCallModel.h
//  Chainverse-SDK
//
//  Created by pham nam on 13/04/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CVSDKContractApproveModel

@end
@interface CVSDKContractConfirmInput : JSONModel
@property (nonatomic, strong) NSString *headTitle;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *asset;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *granted_to;
@property (nonatomic, strong) NSString *contract;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, strong) NSString *function;
@property (nonatomic, strong) NSMutableDictionary *params;
@end

NS_ASSUME_NONNULL_END
