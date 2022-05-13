//
//  ChainverseItem.h
//  Chainverse-SDK
//
//  Created by pham nam on 29/07/2021.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ChainverseItem

@end
@interface ChainverseItem : JSONModel
@property (nonatomic, strong) NSString *item_id;
@property (nonatomic, strong) NSString *category_id;
@property (nonatomic, strong) NSString *game_address;
@property (nonatomic, strong) NSString *attributes;

@end

NS_ASSUME_NONNULL_END
