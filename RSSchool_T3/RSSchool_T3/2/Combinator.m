#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    
    NSInteger k = 0;
    NSInteger m = [array.firstObject integerValue];
    NSInteger n = [array.lastObject integerValue];
    
    NSInteger(^factorial)(NSInteger num);
    
    factorial = ^(NSInteger num) {
        NSInteger number = 1;
        if (num > 0) {
            for (NSInteger i = 1; i <= num; i++) {
                number = i * number;
            }
            return number;
        } else {
            NSInteger numInt = 1;
            return numInt;
        }
    };
    
    while (k < n) {
        k += 1;
        NSInteger result = factorial(n) / (factorial(k) * factorial(n - k));
        if (result >= m) {
            return [NSNumber numberWithInteger:k];
        }
    }
    return nil;
}
@end
