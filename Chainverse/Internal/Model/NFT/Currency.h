//
//  Currency.h
//  Chainverse-SDK
//
//  Created by pham nam on 06/05/2022.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol Currency

@end
@interface Currency : JSONModel
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSInteger decimal;
@property (nonatomic, strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
