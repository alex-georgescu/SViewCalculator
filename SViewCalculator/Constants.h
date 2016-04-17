//
//  Constants.h
//  SViewCalculator
//
//  Created by Alex Georgescu on 04/01/2016.
//  Copyright © 2016 Alex Georgescu. All rights reserved.
//

@interface Constants : NSObject

extern NSString* const ONE;
extern NSString* const TWO;
extern NSString* const THREE;
extern NSString* const FOUR;
extern NSString* const FIVE;
extern NSString* const SIX;
extern NSString* const SEVEN;
extern NSString* const EIGHT;
extern NSString* const NINE;
extern NSString* const ZERO;
extern NSString* const DOT;
extern NSString* const SIGNS;
extern NSString* const EQUALITY;
extern NSString* const ADDITION;
extern NSString* const SUBSTRACTION;
extern NSString* const MULTIPLICATION;
extern NSString* const DIVISION;
extern NSString* const PERCENTAGE;
extern NSString* const RESET;
extern NSString* const DELETE;
extern double const BUTTON_HEIGHT_MULTIPLIER;

typedef enum
{
    NONE = -1,
    EQUALS = 0,
    ADD = 1,
    SUBSTRACT = 2,
    MULTIPLY = 3,
    DIVIDE = 4,
    PERCENT_OFF = 5
    
} OPERATION;

@end
