//
//  CVSDKBaseView.m
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "CVSDKBaseView.h"
#import "CVSDKBaseResource.h"
@implementation CVSDKBaseView

- (instancetype)initViewFromNib{
    NSString *nibName = NSStringFromClass([self class]);
    CVSDKBaseView *view = [[[CVSDKBaseResource getBundle] loadNibNamed:nibName owner:nil options:nil] objectAtIndex:0];
    return view;
}

@end
