//
//  ChainverseItem.m
//  Chainverse-SDK
//
//  Created by pham nam on 29/07/2021.
//

#import "ChainverseItem.h"

@implementation ChainverseItem
- (NSString *)item_id {
    return [self.objectDict objectForKey:@"item_id"];
}

- (NSString *)category_id {
    return [self.objectDict objectForKey:@"category_id"];
}

- (NSString *)game_address {
    return [self.objectDict objectForKey:@"game_address"];
}

- (NSString *)attributes {
    return [self.objectDict objectForKey:@"attributes"];
}
@end
