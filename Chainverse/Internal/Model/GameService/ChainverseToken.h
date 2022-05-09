//
//  ChainverseToken.h
//  Chainverse-SDK
//
//  Created by pham nam on 05/05/2022.
//

#import <Chainverse/Chainverse.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseToken

@end
@interface ChainverseToken : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSInteger decimals;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *abi;
@end

NS_ASSUME_NONNULL_END
