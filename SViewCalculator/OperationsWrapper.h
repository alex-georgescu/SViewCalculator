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
-(NSMutableArray*) infixToPostfix :(NSString*) infixExpression;
-(NSString*) evaluatePostfix :(NSMutableArray*) postfixExp;


@end
