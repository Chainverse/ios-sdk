//
//  CVSDKWallet.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKBridgingWallet.h"
#import "CVSDKUserDefault.h"
@interface CVSDKBridgingWallet(){
    
}
@property (nonatomic, nonatomic) NSString *mnemonic;
@property (nonatomic, nonatomic) CVWallet *wallet;
@end
@implementation CVSDKBridgingWallet
+ (CVSDKBridgingWallet *)shared{
    static CVSDKBridgingWallet *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)initialize{
    self.wallet = [[CVWallet alloc] init];
}
- (NSString *)genMnemonic:(NSInteger *)length{
    self.mnemonic  = [self.wallet genMnemonicWithBitsOfEntropy:*length];
    return self.mnemonic;
}

- (NSString *)getMnemonic{
    if(![self.mnemonic isEqualToString:@""]){
        return self.mnemonic;
    }
    return @"";
}

- (NSString *)importWallet:(NSString *)mnemonics{
    CVWallet *wallet = [[CVWallet alloc] init];
    NSString *address = [wallet importWalletWith_mnemonics:mnemonics];
    return address;
}

- (NSString *)getPrivateKey{
    CVWallet *wallet = [[CVWallet alloc] init];
    NSString *privateKey = [wallet getPrivateKeyWith_mnemonics:[CVSDKUserDefault getMnemonic]];
    return privateKey;
}
@end
