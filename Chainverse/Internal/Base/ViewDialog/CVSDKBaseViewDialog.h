//
//  CVSDKBaseViewDialog.h
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CVSDKBaseView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CVSDKBaseViewDialogDelegate;


@interface CVSDKBaseViewDialog : NSObject{
    UIView *_backgroundView;
    CVSDKBaseView *_dialogView;
}
    

@property (nonatomic, weak) id<CVSDKBaseViewDialogDelegate> delegate;

+ (instancetype)showWithDelegate: (id<CVSDKBaseViewDialogDelegate>)delegate;

- (void)showDialog;
- (BOOL)show;
- (void)cancel;
- (BOOL)showDialogView;
@end

@protocol CVSDKBaseViewDialogDelegate <NSObject>
- (void)viewDialogDidCancel:(CVSDKBaseViewDialog *)viewDialog;

@end

NS_ASSUME_NONNULL_END
