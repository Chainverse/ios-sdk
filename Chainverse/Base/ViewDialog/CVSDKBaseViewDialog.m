//
//  CVSDKBaseViewDialog.m
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import "CVSDKBaseViewDialog.h"

static CVSDKBaseViewDialog *_currentDialog = nil;
static NSMutableArray *_stackDialog;

@interface CVSDKBaseViewDialog() <CVSDKBaseViewDelegate>

@end

@implementation CVSDKBaseViewDialog
+(instancetype)showWithDelegate:(id<CVSDKBaseViewDialogDelegate>)delegate{
    CVSDKBaseViewDialog *dialog = [[self alloc] init];
    dialog.delegate = delegate;
    return dialog;
}

- (void)showDialog{
    if(_currentDialog){
        if(!_stackDialog) _stackDialog = [[NSMutableArray alloc] init];
        
        [_stackDialog addObject:_currentDialog];
        [self show];
        NSLog(@"nampv_dialog1");
    }else{
        [self show];
        NSLog(@"nampv_dialog2");
    }
    
}

- (void) cancel{
    CVSDKBaseViewDialog *dialog = self;
    [self dimissView];
    if([_delegate respondsToSelector:@selector(viewDialogDidCancel:)]){
        [_delegate viewDialogDidCancel:dialog];
    }
}

- (void)dimissBackground{
    BOOL animated = NO;
    UIView *backgroundView = _backgroundView;
    _backgroundView = nil;
    CVSDKBaseView *dialogView = _dialogView;
    
    void(^didDismiss)(BOOL) = ^(BOOL finished) {
        [backgroundView removeFromSuperview];

    };
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            dialogView.alpha = 0.0;
            backgroundView.alpha = 0.0;
        } completion:didDismiss];
    } else {
        didDismiss(YES);
    }
}

- (void)dimissView{
    UIView *backgroundView = _backgroundView;
    _backgroundView = nil;
    CVSDKBaseView *dialogView = _dialogView;
    _dialogView.delegate = nil;
    _dialogView = nil;
    
    [UIView animateWithDuration:0.2 animations:^{
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        [dialogView removeFromSuperview];
     
    }];
    
    
}

- (BOOL)show{
    if(_currentDialog == self){
        return NO;
    }
    
    [_currentDialog dimissBackground];
    _currentDialog = self;

    
    _dialogView.delegate = self;
    [self showDialogView];
    return YES;
}

- (BOOL) showDialogView{
    UIWindow *window = [self findWindow];
    _backgroundView = [[UIView alloc] initWithFrame:window.bounds];
    _backgroundView.alpha = 0.7;
    _backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.tag = -10000000;
    _dialogView.tag = -1000000;
    
    [window addSubview:_backgroundView];
    [window addSubview:_dialogView];
    [_dialogView becomeFirstResponder];
    [self updateViewScale];
    
    return YES;
}

- (void)updateViewScale{
    CGAffineTransform tranform;
    CGRect applicationFrame = [self applicationFrameForOrentation];
    tranform = _dialogView.transform;
    _dialogView.transform = CGAffineTransformIdentity;
    _dialogView.frame = applicationFrame;
    _dialogView.transform = tranform;
    _dialogView.backgroundColor = [UIColor clearColor];
    
    tranform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    _dialogView.transform = tranform;
    
    
    CGRect mainFrame = _dialogView.window.screen.bounds;
    _dialogView.center = CGPointMake(CGRectGetMidX(mainFrame), CGRectGetMidY(mainFrame));
}

- (CGRect)applicationFrameForOrentation{
    CGRect applicationFrame = _dialogView.window.screen.bounds;
    return applicationFrame;
    
}

- (UIWindow *)findWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if(window == nil || window.windowLevel != UIWindowLevelNormal){
        for(window in [UIApplication sharedApplication].windows){
            if(window.windowLevel == UIWindowLevelNormal){
                break;
            }
        }
    }
    return window;
}

#pragma mark -  CVSDKBaseViewDelegate
- (void)viewDidCancel:(CVSDKBaseView *)view{
    [self cancel];
}
@end
