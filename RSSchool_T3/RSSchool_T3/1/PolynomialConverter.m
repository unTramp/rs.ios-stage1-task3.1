#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSArray* inputArray = [NSArray arrayWithArray:numbers];
    if (inputArray.count == 0) {
        return nil;
    }
    NSArray* arrayForResult = [self modifyArray:inputArray];
    NSString* result = [self convertFromFilteredArrayToString:arrayForResult];
    return result;
}

- (NSArray*)modifyArray:(NSArray*)array {
    NSMutableArray* arrayForResult = [[NSMutableArray alloc] init];
    NSInteger index = array.count - 1;
    for (NSInteger i = 0; i < array.count; i++) {
        if ([array[i] isEqual:@(0)]) {
            index -= 1;
            continue;
        }
        if (array[i] != nil) {
            switch ([array[i] integerValue]) {
                case 1:
                    [arrayForResult addObject:@"x"];
                    index -= 1;
                    continue;
                case -1:
                    [arrayForResult addObject:@"-x"];
                    index -= 1;
                    continue;
                default:
                    break;
            }
            if (index == 1) {
                [arrayForResult addObject:[NSMutableString stringWithFormat:@"%@x", array[i]]];
                index -= 1;
                continue;
            } else if (index == 0) {
                [arrayForResult addObject:array[i]];
                break;
            }
            [arrayForResult addObject:[NSMutableString stringWithFormat:@"%@x^%ld", array[i], index]];
            index -= 1;
        } else {
            
            index -= 1;
        }
    }
    return arrayForResult;
}

- (NSString*)convertFromFilteredArrayToString:(NSArray*)array {
    NSMutableString* resultString = [NSMutableString stringWithFormat:@""];
    for (NSInteger index = 0; index < array.count ; index++) {
        if ([resultString isEqualToString:@""]) {
            [resultString appendFormat:@"%@", array[index]];
            continue;
        }
        NSString* elementAsString = [[NSString alloc] init];
        if ([array[index] isKindOfClass:[NSNumber class]]) {
            elementAsString = [array[index] stringValue];
        } else {
            elementAsString = array[index];
        }
        if ([elementAsString hasPrefix:@"-"]) {
            NSMutableString* elementOfArray = [NSMutableString stringWithFormat:@"%@", array[index]];
            [elementOfArray deleteCharactersInRange:NSMakeRange(0, 1)];
            [resultString appendFormat:@" - %@", elementOfArray];
        } else {
            [resultString appendFormat:@" + %@", array[index]];
        }
    }
    return resultString;
}
  
@end
