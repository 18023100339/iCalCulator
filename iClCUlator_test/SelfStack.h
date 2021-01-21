//
//  SelfStack.h
//  iClCUlator_test
//
//  Created by Liu_zc on 2020/1/3.
//  Copyright © 2020 Liu_zc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfStack : NSObject

@property(nonatomic, readonly) NSString *Top;
@property(nonatomic) NSUInteger Stacksize;
@property(nonatomic, readonly) NSMutableArray *stackArray;
@property(nonatomic, readonly) NSString *popElement;

-(instancetype)initWithStacksize:(NSUInteger)Stacksize;//designated initializer

-(BOOL)push:(NSString *)element stack:(SelfStack *)stack;

-(NSString *)pop:(SelfStack *)stack;

-(NSString *)getTop:(SelfStack *)stack;



@end
