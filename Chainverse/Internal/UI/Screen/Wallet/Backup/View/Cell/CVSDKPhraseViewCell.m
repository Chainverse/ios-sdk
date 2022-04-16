//
//  CVSDKPhraseViewCell.m
//  Chainverse-SDK
//
//  Created by pham nam on 01/12/2021.
//

#import "CVSDKPhraseViewCell.h"
#import "CVSDKPhrase.h"
#import "CVSDKUtils.h"
@interface CVSDKPhraseViewCell ()

@property (assign, nonatomic) BOOL alreadyLayout;


@end

@implementation CVSDKPhraseViewCell

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

- (void)setupData:(id)item atIndexPath:(NSIndexPath *)indexPath type:(NSString *)type{
    CVSDKPhrase *phrase = (CVSDKPhrase *)item;
    self.lblBody.text = [phrase body];
    self.lblOrder.text = [NSString stringWithFormat:@"%@",[phrase order]];
    if([type isEqualToString:@"default"]){
        self.lblOrder.hidden = NO;
    }else{
        self.lblOrder.hidden = YES;
    }
    
   
    if([[phrase isShow] isEqualToString:@"true"]){
        self.lblBody.hidden = NO;
        self.viewContainer.backgroundColor = [CVSDKUtils colorWithHexString:@"#F3EEEB"];
        self.viewContainer.layer.cornerRadius = 10;
        self.viewContainer.layer.borderColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
        self.viewContainer.layer.borderWidth = 1.0f;
    }else{
        self.lblBody.hidden = YES;
        self.viewContainer.backgroundColor = [CVSDKUtils colorWithHexString:@"#FFFFFF"];
        self.viewContainer.layer.cornerRadius = 10;
        self.viewContainer.layer.borderColor = [CVSDKUtils colorWithHexString:@"#FFFFFF"].CGColor;
        self.viewContainer.layer.borderWidth = 0.0f;
        
        CAShapeLayer *dashBorder = [CAShapeLayer layer];
        dashBorder.strokeColor = [CVSDKUtils colorWithHexString:@"#DADEE4"].CGColor;
        dashBorder.fillColor = nil;
        dashBorder.lineDashPattern = @[@10, @10];
        dashBorder.frame = self.viewContainer.bounds;
        dashBorder.path = [UIBezierPath bezierPathWithRoundedRect:self.viewContainer.bounds cornerRadius:10].CGPath;
        [self.viewContainer.layer addSublayer:dashBorder];
        
    }
}

@end
