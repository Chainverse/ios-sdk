//
//  CVSDKGameService.h
//  Chainverse-SDK
//
//  Created by pham nam on 05/05/2022.
//

#import <Chainverse/Chainverse.h>
#import "Network.h"
#import "ChainverseToken.h"
#import "ChainverseService.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseGameService

@end
@interface ChainverseGameService : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property(nonatomic, strong)  Network *network_info;
@property (nonatomic, strong) NSMutableArray<ChainverseService> *services;
@property (nonatomic, strong) NSMutableArray<ChainverseToken> *tokens;
@end

NS_ASSUME_NONNULL_END
