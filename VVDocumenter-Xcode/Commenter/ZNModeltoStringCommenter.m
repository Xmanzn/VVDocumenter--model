//
//  ZNModeltoStringCommenter.m
//  VVDocumenter-Xcode
//
//  Created by 嗯你懂的 on 16/10/19.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

#import "ZNModeltoStringCommenter.h"
#import "VVArgument.h"

@implementation ZNModeltoStringCommenter


- (NSString *)captureReturnType {
    NSArray * matchedTypes = [self.code componentsSeparatedByString:@";"];
    NSMutableString *codestring = [NSMutableString stringWithString:@"+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {\nreturn @{"];
    [matchedTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *a = [obj componentsSeparatedByString:@"="];
        if (a.count == 2) {
            NSRange rang = [a[0] rangeOfString:@"self."];
            NSRange valueR = [a[1] rangeOfString:@"@\""];
            if (rang.location != NSNotFound && valueR.location != NSNotFound) {
                NSString *name = [a[0] substringFromIndex:rang.location+rang.length];
                NSString *value = [a[1] substringFromIndex:valueR.location+valueR.length];
                NSRange vr = [value rangeOfString:@"\""];
                if (vr.location!=NSNotFound) {
                    value = [value substringToIndex:vr.location];
                }
                [codestring appendFormat:@"@\"%@\" : @\"%@\",\n",name,value];
            }
        }else if (a.count == 3) {
            NSRange rang = [a[1] rangeOfString:@"self."];
            NSRange valueR = [a[2] rangeOfString:@"@\""];
            if (rang.location != NSNotFound && valueR.location != NSNotFound) {
                NSString *name = [a[1] substringFromIndex:rang.location+rang.length];
                NSString *value = [a[2] substringFromIndex:valueR.location+valueR.length];
                NSRange vr = [value rangeOfString:@"\""];
                if (vr.location!=NSNotFound) {
                    value = [value substringToIndex:vr.location];
                }
                [codestring appendFormat:@"@\"%@\" : @\"%@\",\n",name,value];
            }
        }
    }];
    [codestring appendString:@"};\n}"];
    return codestring;
}

-(NSString *)document {
    return [self captureReturnType];
}
//-(NSString *) document
//{
////    [self captureReturnType];
////    [self captureParameters];
//    
////    return [super documentForC];
//    
//    return [self captureReturnType];
//}


@end
