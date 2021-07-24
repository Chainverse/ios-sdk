//
//  CVSDKBaseView.h
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CVSDKBaseViewDelegate;

@interface CVSDKBaseView : UIView
@property (nonatomic, weak) id<CVSDKBaseViewDelegate> delegate;
- (instancetype)initViewFromNib;


@end

@protocol CVSDKBaseViewDelegate <NSObject>
- (void)viewDidCancel: (CVSDKBaseView *)view;
@end

NS_ASSUME_NONNULL_END
