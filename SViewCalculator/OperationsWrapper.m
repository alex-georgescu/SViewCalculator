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
#import "RegexKitLite.h"

@implementation OperationsWrapper

-(void) initMetadata
{
    GlobalOperators = [NSDictionary dictionaryWithObjects:@[@"1",@"1",@"2",@"2",@"4",@"4",@"3",@"3"]
                                                         forKeys:@[ADDITION,SUBTRACTION,MULTIPLICATION,DIVISION, OPEN_PARANTHESES,CLOSED_PARANTHESES,POWER_CARET,ROOT_CARET]];
}


-(NSMutableArray*) infixToPostfix :(NSMutableArray*) infix
{
    /*
     1. scan infix from left to right
     2. create a STACK and POSTFIX
     3. if the scanned char is an operand, add it to the POSTFIX;
        if the scanned char is an operator:
        - if STACK is empty, push it to STACK
        - if STACK is NOT empty, compare the precedence; if top-stack has higher precedence, pop the STACK and add to POSTFIX, else push the scanned char on to the STACK; repeat while STACK is NOT empty and top-stack has higher precedence than scanned character
     4. while STACK is not empty, pop and add to POSTFIX
     5. return POSTFIX
    */
    
    NSMutableArray* postfix = [[NSMutableArray alloc] init];
    NSMutableArray* stack = [[NSMutableArray alloc] init];
    
    for (NSString* symbol in infix)
    {
        // is it an operator?
        if ([GlobalOperators valueForKey:(symbol)])
        {
            if (stack.count == 0)
            {
                [stack addObject:symbol];
            }
            else
            {
                while (stack.count > 0
                       &&
                       [GlobalOperators valueForKey:stack[stack.count - 1]] >= [GlobalOperators valueForKey:(symbol)])
                {
                    [postfix addObject:stack[stack.count - 1]];
                    
                    [stack removeLastObject];
                }
                
                [stack addObject:symbol];
            }
        }
        else
        {
            [postfix addObject:symbol];
        }
    }
             
    while (stack.count > 0)
    {
        [postfix addObject:stack[stack.count - 1]];

        [stack removeLastObject];
    }
    
    return postfix;
}


-(NSString*) evaluatePostfix :(NSMutableArray*) postfixExp
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

    for(int i = 0; i < postfixExp.count; i++)
    {
        postfixChar = [postfixExp objectAtIndex:(i)];
        
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
                
                NSNumber* quickRes;
                if ([postfixChar isEqualToString: ADDITION])
                {
                    quickRes = @([operator2 doubleValue] + [ operator1 doubleValue]);
                }
                else if ([postfixChar isEqualToString: SUBTRACTION])
                {
                    quickRes = @([operator2 doubleValue] - [ operator1 doubleValue]);
                }
                else if ([postfixChar isEqualToString: MULTIPLICATION])
                {
                    quickRes = @([operator2 doubleValue] * [ operator1 doubleValue]);
                }
                else if ([postfixChar isEqualToString: DIVISION])
                {
                    quickRes = @([operator2 doubleValue] / [ operator1 doubleValue]);
                }
                else if ([postfixChar isEqualToString: POWER_CARET])
                {
                    quickRes = @(pow([operator2 doubleValue], [ operator1 doubleValue]));
                }
                else if ([postfixChar isEqualToString: ROOT_CARET])
                {
                    double base = [operator1 doubleValue];
                    double root = [operator2 doubleValue];
                    
                    while(fmod(root, 3.0) > 1.0)
                    {
                        root /= 3.0;
                        
                        base = cbrt(base);
                    }
                    
                    quickRes = @(pow(base, 1.0 / root));
                }
                else if ([postfixChar isEqualToString: OPEN_PARANTHESES])
                {
                    // prepare stack for future recursive processing
                }
                else if ([postfixChar isEqualToString: CLOSED_PARANTHESES])
                {
                    // start processing
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



-(NSString*) solveEquation :(NSString*) inputString
{
    //According to Apple's documentation, these characters must be quoted (using \) to be treated as literals:
    //* ? + [ ( ) { } ^ $ | \ . /
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: @"\\(.*\\)" options:0 error:nil];
    NSArray* matches = [regex matchesInString:inputString options:0 range: NSMakeRange(0, [inputString length])];
    
    if (matches.count == 1)
    {
        NSTextCheckingResult* match = matches[0];
        NSString* matchedText = [inputString substringWithRange:[match range]];
        NSLog(@"match: %@", matchedText);
        
        NSString* partialResult = [self solveEquation:[matchedText substringWithRange:NSMakeRange(1, matchedText.length-2)]];
        inputString = [inputString stringByReplacingOccurrencesOfString:matchedText withString:partialResult];
    }
    
    NSMutableArray* infixInputArray = [[NSMutableArray alloc] init];
    
    //Parse user input and split it into OPERANDS and OPERATORS
    //According to Apple's documentation, these characters must be quoted (using \) to be treated as literals:
    //* ? + [ ( ) { } ^ $ | \ . /
    NSArray* regexMatches = [inputString componentsSeparatedByRegex:@"(?<=[+-÷x\\^√])(\\d+(?:\\.\\d+)?)|(\\d+(?:\\.\\d+)?)(?=[+-÷x\\^√])"];
    for (NSString* matched in regexMatches)
    {
        //validate operator (ex: it only has 1 decimal point)
        if ([matched componentsSeparatedByString:@"."].count > 2)
        {
            //TODO:
            NSLog(@"Oops! Operand %@ has more than 1 decimal point.", matched);
            return nil;
        }
        
        if (matched.length > 0)
        {
            [infixInputArray addObject:matched];
        }
    }
    
    NSMutableArray* evaluatedInputArray = [self infixToPostfix: infixInputArray];
    NSLog(@"postfix: %@", evaluatedInputArray);
    
    NSString* evaluatedPostfix = [self evaluatePostfix: evaluatedInputArray];
    NSLog(@"result: %@", evaluatedPostfix);
    
    return evaluatedPostfix;
}


@end
