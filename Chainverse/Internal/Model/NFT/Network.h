//
//  Network.h
//  Chainverse-SDK
//
//  Created by pham nam on 06/05/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol Network

@end
@interface Network : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *network;
@property (nonatomic, strong) NSString *chain_id;
@property (nonatomic, strong) NSString *rpcs;
@end

NS_ASSUME_NONNULL_END
