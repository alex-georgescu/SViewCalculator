//
//  ViewController.m
//  SViewCalculator
//
//  Created by Alex Georgescu on 03/01/2016.
//  Copyright © 2016 Alex Georgescu. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"


@implementation ViewController

-(UIButton*)createCustomButton :(UIButton*) button
                 parentView:(UIView*) superview
            backgroundColor:(UIColor*) backgroundColor
                  withTitle:(NSString*) title
                 titleColor:(UIColor*) titleColor
                borderColor:(UIColor*) borderColor
                borderWidth:(double) borderWidth
{
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.backgroundColor = backgroundColor;
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor =[[UIColor grayColor] CGColor];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    [superview addSubview:button];
    
    return button;
}



-(void)createResultTextArea
{
    
    // 1. Create TEXT AREA and add to our view
    self.uilNumbersArea = [[UITextField alloc] init];
    self.uilNumbersArea.borderStyle = UITextBorderStyleRoundedRect;
    self.uilNumbersArea.textAlignment = NSTextAlignmentRight;
    self.uilNumbersArea.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.uilNumbersArea.font = [UIFont systemFontOfSize:24];
    self.uilNumbersArea.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Prevent keyboard from showing up when editing read-only text field
    self.uilNumbersArea.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.uilNumbersArea setDelegate:self];
    [self.view addSubview:self.uilNumbersArea];
    
    
    // 2. Text field Constraints
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uilNumbersArea attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                                           toItem:self.view attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:20];
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uilNumbersArea attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual toItem:self.view attribute:
                                            NSLayoutAttributeLeft multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uilNumbersArea attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.view attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:-5];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uilNumbersArea attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:0.183 constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfLeftConstraint, tfRightConstraint, tfHeightConstraint]];
}


- (BOOL) textField: (UITextField *)theTextField
shouldChangeCharactersInRange:(NSRange)range
 replacementString: (NSString *)string
{
    //return yes or no after comparing the characters
    
    // allow backspace and minus
    if (!string.length
        ||
        (theTextField.text.length == 0 && [string compare:@"-"] == NSOrderedSame))
    {
        return YES;
    }
    
    // allow doubles
    if ([string doubleValue]
        ||
        ([string compare:@"."] ==  NSOrderedSame && [theTextField.text containsString:@"."] == false))
    {
        return YES;
    }
    
    return NO;
}


-(void)createDelButton
{
    self.uibDelete = [self createCustomButton:self.uibDelete
                                  parentView:self.view
                             backgroundColor:[UIColor lightGrayColor]
                                   withTitle:DELETE
                                  titleColor:[UIColor blackColor]
                                 borderColor:[UIColor grayColor]
                                 borderWidth:1.0f];
    
    [self.uibDelete addTarget:self
                    action:@selector(removeLastDigitFromResult)
                    forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uibDelete attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uilNumbersArea attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibDelete attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uibDelete attribute:NSLayoutAttributeWidth
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                            multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uibDelete attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.view attribute:NSLayoutAttributeHeight
                                            multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfLeftConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createResetButton
{
    self.uibReset = [self createCustomButton:self.uibReset
                                  parentView:self.view
                             backgroundColor:[UIColor lightGrayColor]
                                   withTitle:RESET
                                  titleColor:[UIColor blackColor]
                                 borderColor:[UIColor grayColor]
                                 borderWidth:1.0f];
    
    [self.uibReset addTarget:self
                   action:@selector(resetInput)
                   forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uibReset
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uibDelete
                                            attribute:NSLayoutAttributeRight
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibReset
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibReset attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibReset attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// %
-(void)createPercentButton
{
    self.uibPercent = [self createCustomButton:self.uibPercent
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:PERCENTAGE
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
   
    self.uibPercent.tag = PERCENT_OFF;
    
    [self.uibPercent addTarget:self
                     action:@selector(calculateResult:)
                     forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPercent
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibReset
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibPercent
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPercent attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibPercent attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// :
-(void)createDivisionButton
{
    self.uibDiv = [self createCustomButton:self.uibDiv
                  parentView:self.view
             backgroundColor:[UIColor orangeColor]
                   withTitle:DIVISION
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    self.uibDiv.tag = DIVIDE;
    
    [self.uibDiv addTarget:self
                    action:@selector(calculateResult:)
                 forControlEvents:UIControlEventTouchUpInside];

    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDiv
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibPercent
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibDiv attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDiv attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibDiv attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton7
{
    self.uib7 = [self createCustomButton:self.uib7
                  parentView:self.view
                 backgroundColor:[UIColor lightGrayColor]
                   withTitle:SEVEN
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uib7 attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual toItem:self.uilNumbersArea
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib7 attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual toItem:self.uibDelete
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib7 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib7 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfLeftConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton8
{
    self.uib8 = [self createCustomButton:self.uib8
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:EIGHT
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib8
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib7
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib8
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibReset
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib8 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib8 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton9
{
    self.uib9 = [self createCustomButton:self.uib9
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:NINE
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib9
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib8
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib9
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibPercent
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib9 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib9 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// x
-(void)createMultiplyButton
{
    self.uibMultiply = [self createCustomButton:self.uibMultiply
                  parentView:self.view
             backgroundColor:[UIColor orangeColor]
                   withTitle:MULTIPLICATION
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    self.uibMultiply.tag = MULTIPLY;
    
    [self.uibMultiply addTarget:self
                         action:@selector(calculateResult:)
        forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibMultiply
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib9
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibMultiply
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibDiv
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibMultiply attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibMultiply attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton4
{
    self.uib4 = [self createCustomButton:self.uib4
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:FOUR
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uib4
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uib7
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib4
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib7
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib4 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib4 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfLeftConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton5
{
    self.uib5 = [self createCustomButton:self.uib5
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:FIVE
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib5
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib4
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib5
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib8
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib5 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib5 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton6
{
    self.uib6 = [self createCustomButton:self.uib6
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:SIX
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib6
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib5
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib6
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib9
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib6 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib6 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// -
-(void)createMinusButton
{
    self.uibMinus = [self createCustomButton:self.uibMinus
                  parentView:self.view
             backgroundColor:[UIColor orangeColor]
                   withTitle:SUBSTRACTION
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    self.uibMinus.tag = SUBSTRACT;
    
    [self.uibMinus addTarget:self
                      action:@selector(calculateResult:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibMinus
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib6
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibMinus
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibMultiply
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibMinus attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibMinus attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton1
{
    self.uib1 = [self createCustomButton:self.uib1
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:ONE
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uib1
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uib4
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib1
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib4
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib1 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib1 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfLeftConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton2
{
    self.uib2 = [self createCustomButton:self.uib2
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:TWO
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib2
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib1
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib2
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib5
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib2 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib2 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton3
{
    self.uib3 = [self createCustomButton:self.uib3
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:THREE
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib3
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib2
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib3
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib6
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib3 attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uib3 attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// +
-(void)createPlusButton
{
    self.uibPlus = [self createCustomButton:self.uibPlus
                  parentView:self.view
             backgroundColor:[UIColor orangeColor]
                   withTitle:ADDITION
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    self.uibPlus.tag = ADD;
    
    [self.uibPlus addTarget:self
                  action:@selector(calculateResult:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPlus
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib3
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibPlus
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibMinus
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPlus attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibPlus attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createButton0
{
    self.uibZero = [self createCustomButton:self.uibZero
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:ZERO
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibZero
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib1
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibZero
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib1
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibZero attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibZero attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createDotButton
{
    self.uibDot = [self createCustomButton:self.uibDot
                  parentView:self.view
             backgroundColor:[UIColor lightGrayColor]
                   withTitle:DOT
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDot
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibZero
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibDot
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib2
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDot attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibDot attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


-(void)createSignButton
{
    self.uibSign = [self createCustomButton:self.uibSign
                                parentView:self.view
                           backgroundColor:[UIColor lightGrayColor]
                                 withTitle:SIGNS
                                titleColor:[UIColor blackColor]
                               borderColor:[UIColor grayColor]
                               borderWidth:1.0f];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibSign
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibDot
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibSign
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib3
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibSign attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibSign attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// =
-(void)createEqualsButton
{
    self.uibEquals = [self createCustomButton:self.uibEquals
                  parentView:self.view
             backgroundColor:[UIColor orangeColor]
                   withTitle:EQUALITY
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    self.uibEquals.tag = EQUALS;
    
    [self.uibEquals addTarget:self
                       action:@selector(calculateResult:)
        forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibEquals
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibSign
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibEquals
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibPlus
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibEquals attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibEquals attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create and align text area
    [self createResultTextArea];
    
    // create and align calculating buttons
    [self createDelButton];
    [self createResetButton];
    [self createPercentButton];
    [self createDivisionButton];
    
    [self createButton7];
    [self createButton8];
    [self createButton9];
    [self createMultiplyButton];

    [self createButton4];
    [self createButton5];
    [self createButton6];
    [self createMinusButton];
    
    [self createButton1];
    [self createButton2];
    [self createButton3];
    [self createPlusButton];
    
    [self createButton0];
    [self createDotButton];
    [self createSignButton];
    [self createEqualsButton];

}


-(void)resetInput
{
    self.uilNumbersArea.text = @"";
}


-(void)removeLastDigitFromResult
{
    if (self.uilNumbersArea.text.length > 1)
    {
        self.uilNumbersArea.text = [self.uilNumbersArea.text substringToIndex:self.uilNumbersArea.text.length - 1];
    }
    else
    {
        [self resetInput];
    }
}


double _operandOne = INT32_MAX;
double _operandTwo = INT32_MAX;
OPERATION _operator = NONE;


-(void)calculateResult : (UIButton*) sender
{
    OPERATION newOperation = (OPERATION)sender.tag;
    
   // if we have both operators it means we also have the operator between them
    if (_operandOne != INT32_MAX && _operandTwo != INT32_MAX)
    {
        if (newOperation == PERCENT_OFF)
        {
            _operandTwo = _operandTwo * 0.01;
        }
        
        switch (_operator)
        {
            case ADD:
                _operandOne = _operandOne + _operandTwo;
                break;
                
            case SUBSTRACT:
                _operandOne = _operandOne - _operandTwo;
                break;
                
            case MULTIPLY:
                _operandOne = _operandOne * _operandTwo;
                break;
                
            case DIVIDE:
                _operandOne = _operandOne / _operandTwo;
                break;
        }
        
        self.uilNumbersArea.text = [NSString stringWithFormat:@"%f", _operandOne];
        
        // prepare for next calculus
        _operandTwo = INT32_MAX;
        _operator = NONE;
    
    }
    // save the missing operator for future reference
    else if (self.uilNumbersArea.text.length > 0)
    {
        double inputData = [self.uilNumbersArea.text doubleValue];
        if (newOperation == PERCENT_OFF)
        {
            inputData = inputData * 0.01;
        }
        
        if (_operandOne == INT32_MAX)
        {
            _operandOne = inputData;
        }
        else if (_operandTwo == INT32_MAX)
        {
            _operandTwo = inputData;
        }
    }
    
    // save the new operation
    _operator = newOperation;
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
