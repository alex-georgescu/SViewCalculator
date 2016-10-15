//
//  Operations.m
//  SViewCalculator
//
//  Created by Alex Georgescu on 21/08/2016.
//  Copyright © 2016 Alex Georgescu. All rights reserved.
//

#import "OperationsWrapper.h"
#import "Constants.h"

@implementation OperationsWrapper

-(void) initMetadata
{
    GlobalOperators = [NSDictionary dictionaryWithObjects:@[@"1",@"1",@"2",@"2",@"2",@"4",@"4",@"3",@"3"]
                                                         forKeys:@[ADDITION,SUBTRACTION,MULTIPLICATION,DIVISION,PERCENTAGE, OPEN_PARANTHESES,CLOSED_PARANTHESES,POWER,ROOT]];
}


-(NSString*) infixToPostfix :(NSString*) infix
{
    /*
     1. scan infix from left to right
     2. create a STACK and POSTFIX string
     3. if the scanned char is an operand, add it to the POSTFIX string;
        if the scanned char is an operator:
        - if STACK is empty, push it to STACK
        - if STACK is NOT empty, compare the precedence; if top-stack has higher precedence, pop the STACK and add to POSTFIX, else push the scanned char on to the STACK; repeat while STACK is NOT empty and top-stack has higher precedence than scanned character
     4. while STACK is not empty, pop and add to POSTFIX string
     5. return POSTFIX
    */
    
    
    NSString* postfix = [[NSString alloc] init];
    NSMutableArray* stack = [[NSMutableArray alloc] init];
    NSString* charSelected = NULL;
    
    for (int i = 0; i < infix.length; i++)
    {
        charSelected = [infix substringWithRange:NSMakeRange(i, 1)];
        
        // is it an operator?
        if ([GlobalOperators valueForKey:(charSelected)])
        {
            if (stack.count == 0)
            {
                [stack addObject:charSelected];
            }
            else
            {
                while ([GlobalOperators valueForKey:stack[stack.count - 1]] > charSelected && stack.count > 0)
                {
                    postfix = [postfix stringByAppendingString:stack[stack.count - 1]];

                    [stack removeLastObject];
                }
                
                [stack addObject:charSelected];
            }
        }
        else
        {
            postfix = [postfix stringByAppendingString:charSelected];
        }
    }
             
    while (stack.count > 0)
    {
        postfix = [postfix stringByAppendingString:stack[stack.count - 1]];

        [stack removeLastObject];
    }
    
    return postfix;
}

@end
