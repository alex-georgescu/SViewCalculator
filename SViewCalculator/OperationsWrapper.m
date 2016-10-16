//
//  Operations.m
//  SViewCalculator
//
//  Created by Alex Georgescu on 21/08/2016.
//  Copyright © 2016 Alex Georgescu. All rights reserved.
//

#include <math.h>
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


-(NSString*) evaluatePostfix :(NSString*) postfixExp
{
    /*
     1. Scan the Postfix string from left to right.
     2. Initialise an empty stack.
     3. If the scannned character is an operand, add it to the stack. If the scanned character is an operator, there will be atleast two operands in the stack.
     4. If the scanned character is an Operator, then we store the top most element of the stack(topStack) in a variable temp. Pop the stack. Now evaluate topStack(Operator)temp. Let the result of this operation be retVal. Pop the stack and Push retVal into the stack.
     5. Repeat this step till all the characters are scanned.
     6. After all characters are scanned, we will have only one element in the stack. Return topStack.
    */
    
    NSString* result = [[NSString alloc] init];
    NSString* postfixChar;
    NSMutableArray* stack = [[NSMutableArray alloc] init];

    for(int i = 0; i < postfixExp.length; i++)
    {
        postfixChar = [postfixExp substringWithRange:NSMakeRange(i, 1)];
        
        //operator
        if ([GlobalOperators valueForKey:(postfixChar)])
        {
            if (stack.count >= 2)
            {
                NSNumberFormatter *nrFormatter = [[NSNumberFormatter alloc] init];
                nrFormatter.numberStyle = NSNumberFormatterDecimalStyle;
                
                NSNumber *operator1 = [nrFormatter numberFromString:stack[stack.count - 1]];
                [stack removeLastObject];
                
                NSNumber *operator2 = [nrFormatter numberFromString:stack[stack.count - 1]];
                [stack removeLastObject];
                
                NSNumber* quickRes = @([operator1 doubleValue]);
                if (postfixChar == ADDITION)
                {
                    quickRes = @([quickRes doubleValue] + [ operator2 doubleValue]);
                }
                else if (postfixChar == SUBTRACTION)
                {
                    quickRes = @([quickRes doubleValue] - [ operator2 doubleValue]);
                }
                else if (postfixChar == MULTIPLICATION)
                {
                    quickRes = @([quickRes doubleValue] * [ operator2 doubleValue]);
                }
                else if (postfixChar == DIVISION)
                {
                    quickRes = @([quickRes doubleValue] / [ operator2 doubleValue]);
                }
                else if (postfixChar == POWER)
                {
                    quickRes = @(pow([quickRes doubleValue], [ operator2 doubleValue]));
                }
                else if (postfixChar == ROOT)
                {
                    quickRes = @(pow([operator2 doubleValue], 1.0/[quickRes doubleValue]));
                }
                else if (postfixChar == OPEN_PARANTHESES)
                {
                
                }
                else if (postfixChar == CLOSED_PARANTHESES)
                {
                
                }
                
                NSString* newOperand = [quickRes stringValue];
                [stack addObject:newOperand];
            }
            else
            {
                result = @"Error parsing the expression. Please check it and try again.";
                break;
            }
        }
        // operand
        else
        {
            [stack addObject:postfixChar];
        }
    }
    
    if (result.length == 0 && stack.count == 1)
        result = stack[stack.count - 1];
    
    [stack removeAllObjects];
    
    return result;
}


@end
