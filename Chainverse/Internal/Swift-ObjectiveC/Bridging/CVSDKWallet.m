//
//  CVSDKWallet.m
//  Chainverse-SDK
//
//  Created by pham nam on 30/11/2021.
//

#import "CVSDKWallet.h"
#import "CVSDKUserDefault.h"
@implementation CVSDKWallet
+ (NSString *)createMnemonics:(NSInteger *)length{
    CVWallet *wallet = [[CVWallet alloc] init];
    NSString *mnemonic  = [wallet createMnemonicsWithBitsOfEntropy:*length];
    return mnemonic;
}

+ (NSString *)importWallet:(NSString *)mnemonics{
    CVWallet *wallet = [[CVWallet alloc] init];
    NSString *address = [wallet importWalletWithMnemonics:mnemonics];
    return address;
}

+ (NSString *)getPrivateKey{
    CVWallet *wallet = [[CVWallet alloc] init];
    NSString *privateKey = [wallet getPrivateKeyWith_mnemonics:[CVSDKUserDefault getMnemonic]];
    return privateKey;
}

+ (NSString *)signMessage:(NSString *)message{
    CVWallet *wallet = [[CVWallet alloc] init];
    NSString *privateKey = [self getPrivateKey];
    NSLog([NSString stringWithFormat:@"Sign message with private key: %@, message: %@", privateKey, message]);
    return [NSString stringWithFormat:@"0x%@",[wallet signMessageWithPrivateKey:privateKey msg:message]];
}

+ (NSString *)signFuck:(NSString *)mnemonics{
    CVWallet *wallet = [[CVWallet alloc] init];
    return [wallet signFuckWith_mnemonics:mnemonics];
}
@end
