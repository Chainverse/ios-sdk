//
//  ChainverseUser.h
//  Chainverse-SDK
//
//  Created by pham nam on 01/09/2021.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseUser

@end
@interface ChainverseUser : JSONModel
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *signature;

@end

NS_ASSUME_NONNULL_END
