//
//  Operations.h
//  SViewCalculator
//
//  Created by Alex Georgescu on 21/08/2016.
//  Copyright © 2016 Alex Georgescu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OperationsWrapper : NSObject
{
    NSDictionary* GlobalOperators;
}

-(void) initMetadata;
-(NSString*) infixToPostfix :(NSString*) infixExpression;
-(NSString*) evaluatePostfix :(NSString*) postfixExp;


@end
