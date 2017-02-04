//
//  ViewController.m
//  SViewCalculator
//
//  Created by Alex Georgescu on 03/01/2016.
//  Copyright © 2016 Alex Georgescu. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "OperationsWrapper.h"
#import "RegexKitLite.h"


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
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uibReset
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uilNumbersArea
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibReset
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibReset
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibReset
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view
                                              attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfLeftConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// " ( "
-(void)createOpenParanthesesButton
{
    self.uibOpenParantheses = [self createCustomButton:self.uibOpenParantheses
                                   parentView:self.view
                              backgroundColor:[UIColor lightGrayColor]
                                    withTitle:OPEN_PARANTHESES
                                   titleColor:[UIColor blackColor]
                                  borderColor:[UIColor grayColor]
                                  borderWidth:1.0f];
    
    [self.uibOpenParantheses addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibOpenParantheses
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibReset
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibOpenParantheses
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibOpenParantheses
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibOpenParantheses
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view
                                              attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// " ) "
-(void)createClosedParanthesesButton
{
    self.uibClosedParantheses = [self createCustomButton:self.uibClosedParantheses
                                  parentView:self.view
                             backgroundColor:[UIColor lightGrayColor]
                                   withTitle:CLOSED_PARANTHESES
                                  titleColor:[UIColor blackColor]
                                 borderColor:[UIColor grayColor]
                                 borderWidth:1.0f];
    
    [self.uibClosedParantheses addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibClosedParantheses
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibOpenParantheses
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibClosedParantheses
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibClosedParantheses
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibClosedParantheses
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
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
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDelete
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibClosedParantheses
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibDelete
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:5];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDelete
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibDelete
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfRightConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// X power Y
-(void)createPowerYButton
{
    self.uibPowerY = [self createCustomButton:self.uibPowerY
                                    parentView:self.view
                               backgroundColor:[UIColor lightGrayColor]
                                     withTitle:POWER
                                    titleColor:[UIColor blackColor]
                                   borderColor:[UIColor grayColor]
                                   borderWidth:1.0f];
    
    [self.uibPowerY addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibPowerY
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibReset
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPowerY
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibPowerY
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view attribute:NSLayoutAttributeHeight
                                              multiplier:BUTTON_HEIGHT_MULTIPLIER constant:0];
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uibPowerY
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uilNumbersArea
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    [self.view addConstraints:@[tfTopConstraint, tfLeftConstraint, tfWidthConstraint, tfHeightConstraint]];
}


// Y-th root of X
-(void)createRootYButton
{
    self.uibRootY = [self createCustomButton:self.uibRootY
                                parentView:self.view
                           backgroundColor:[UIColor lightGrayColor]
                                 withTitle:ROOT
                                titleColor:[UIColor blackColor]
                               borderColor:[UIColor grayColor]
                               borderWidth:1.0f];
    
    [self.uibRootY addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibRootY
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibPowerY
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibRootY
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibOpenParantheses
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibRootY
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibRootY
                                              attribute:NSLayoutAttributeHeight
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
   
    [self.uibPercent addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPercent
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibRootY
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibPercent
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibClosedParantheses
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPercent
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea
                                             attribute:NSLayoutAttributeWidth
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
    
    [self.uibDiv addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDiv
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibPercent
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibDiv
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibDelete
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfWidthConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDiv
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uilNumbersArea
                                             attribute:NSLayoutAttributeWidth
                                             multiplier:0.25 constant:0];
    
    NSLayoutConstraint *tfHeightConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.uibDiv
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view
                                              attribute:NSLayoutAttributeHeight
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
    
    [self.uib7 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uib7 attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual toItem:self.uilNumbersArea
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib7
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibPowerY
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
    
    [self.uib8 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
                                           toItem:self.uibRootY
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
    
    [self.uib9 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.uibMultiply addTarget:self
                     action:@selector(addToInput:)
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
    
    [self.uib4 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.uib5 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.uib6 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
                   withTitle:SUBTRACTION
                  titleColor:[UIColor blackColor]
                 borderColor:[UIColor grayColor]
                 borderWidth:1.0f];
    
    [self.uibMinus addTarget:self
                     action:@selector(addToInput:)
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
    
    [self.uib1 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.uib2 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.uib3 addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.uibPlus addTarget:self
                     action:@selector(addToInput:)
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
    
    [self.uibZero addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.uibDot addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.uibSign addTarget:self
                     action:@selector(addToInput:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    [self createResetButton];
    [self createOpenParanthesesButton];
    [self createClosedParanthesesButton];
    [self createDelButton];
    
    [self createPowerYButton];
    [self createRootYButton];
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


-(void)addToInput : (UIButton*) sender
{
    [self.uilNumbersArea replaceRange:self.uilNumbersArea.selectedTextRange withText:sender.titleLabel.text];
}


-(void)calculateResult : (UIButton*) sender
{
    OperationsWrapper* opWrap = [[OperationsWrapper alloc] init];
    [opWrap initMetadata];
    
    //Parse user input and split it into OPERANDS and OPERATORS
    //According to Apple's documentation, these characters must be quoted (using \) to be treated as literals:
    //* ? + [ ( ) { } ^ $ | \ . /
    NSMutableArray* infixInputArray = [[NSMutableArray alloc] init];
    NSString* userInputString = self.uilNumbersArea.text;
    NSString* regexPattern = @"(?<=[+-÷x])(\\d+(?:\\.\\d+)?)|(\\d+(?:\\.\\d+)?)(?=[+-÷x])";
    
    NSArray* regexMatches = [userInputString componentsSeparatedByRegex:regexPattern];
    for (NSString* matched in regexMatches)
    {
        //validate operator (ex: it only has 1 decimal point)
        if ([matched componentsSeparatedByString:@"."].count > 2)
        {
            //TODO:
            NSLog(@"Oops! Operand %@ has more than 1 decimal point.", matched);
            return;
        }
        
        if (matched.length > 0)
        {
            [infixInputArray addObject:matched];
        }
    }

    NSMutableArray* evaluatedInputArray = [opWrap infixToPostfix: infixInputArray];
    NSLog(@"postfix: %@", evaluatedInputArray);
    
    NSString* evaluatedPostfix = [opWrap evaluatePostfix: evaluatedInputArray];
    NSLog(@"result: %@", evaluatedPostfix);
    
    self.uilNumbersArea.text = evaluatedPostfix;
}


-(NSArray*) split:(NSString *)str useRegex:(NSRegularExpression *) regex
{
    NSRange range = NSMakeRange(0, str.length);
    
    //get locations of matches
    NSMutableArray* matchingRanges = [NSMutableArray array];
    NSArray* matches = [regex matchesInString:str options:0 range:range];
    for(NSTextCheckingResult* match in matches)
    {
        [matchingRanges addObject:[NSValue valueWithRange:match.range]];
    }
    
    //invert ranges - get ranges of non-matched pieces
    NSMutableArray* pieceRanges = [NSMutableArray array];
    
    //add first range
    [pieceRanges addObject:[NSValue valueWithRange:NSMakeRange(0,
                                                               (matchingRanges.count == 0 ? str.length : [matchingRanges[0] rangeValue].location))]];
    
    //add between splits ranges and last range
    for(int i=0; i<matchingRanges.count; i++){
        BOOL isLast = i+1 == matchingRanges.count;
        unsigned long startLoc = [matchingRanges[i] rangeValue].location + [matchingRanges[i] rangeValue].length;
        unsigned long endLoc = isLast ? str.length : [matchingRanges[i+1] rangeValue].location;
        [pieceRanges addObject:[NSValue valueWithRange:NSMakeRange(startLoc, endLoc-startLoc)]];
    }
    
    //use split ranges to select pieces
    NSMutableArray* pieces = [NSMutableArray array];
    for(NSValue* val in pieceRanges) {
        NSRange range = [val rangeValue];
        NSString* piece = [str substringWithRange:range];
        [pieces addObject:piece];
    }
    
    return pieces;
}


-(bool)isOperator: (NSString*) input
{
    if ([input isEqualToString: ADDITION]
        ||
        [input isEqualToString: SUBTRACTION]
        ||
        [input isEqualToString: MULTIPLICATION]
        ||
        [input isEqualToString: DIVISION]
        ||
        [input isEqualToString: POWER]
        ||
        [input isEqualToString: ROOT]
        ||
        [input isEqualToString: OPEN_PARANTHESES]
        ||
        [input isEqualToString: CLOSED_PARANTHESES])
    {
        return true;
    }
    
    return false;
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
