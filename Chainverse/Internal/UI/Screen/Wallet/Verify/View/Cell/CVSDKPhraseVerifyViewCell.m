//
//  CVSDKPhraseViewCell.m
//  Chainverse-SDK
//
//  Created by pham nam on 01/12/2021.
//

#import "CVSDKPhraseVerifyViewCell.h"
#import "CVSDKPhrase.h"
#import "CVSDKUtils.h"
@interface CVSDKPhraseVerifyViewCell ()

@property (assign, nonatomic) BOOL alreadyLayout;


@end

@implementation CVSDKPhraseVerifyViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.alreadyLayout) {
        self.alreadyLayout = YES;
        self.viewContainer.layer.cornerRadius = 10;
        self.viewContainer.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
        self.viewContainer.layer.borderWidth = 1.0f;
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupData:(id)item atIndexPath:(NSIndexPath *)indexPath{
    CVSDKPhrase *phrase = (CVSDKPhrase *)item;
    self.lblBody.text = [phrase body];
    self.lblOrder.text = [NSString stringWithFormat:@"%@",[phrase order]];
    
    self.lblBody.hidden = YES;
    if([[phrase isShow] isEqualToString:@"true"]){
        self.lblBody.hidden = NO;
    }
}

@end
