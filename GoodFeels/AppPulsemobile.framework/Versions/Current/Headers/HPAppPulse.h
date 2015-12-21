//
//  HPAppPulse.h
//  RUMService
//
//  Created by efrat on 3/25/15.
//  Copyright (c) 2015 HP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//for backwards compatability
#define HPUserMonitoringSDK HPAppPulse

@interface HPAppPulse : NSObject
+ (BOOL) getOptStatus;
+ (void) setOptStatus: (BOOL) status;

typedef enum HPControlType{
    HPButtonControl,
    HPTabControl,
    HPSwitchControl,
    HPStepperControl,
    HPSliderControl,
    HPSearchBarControl,
    HPNavigationBarControl,
    HPListItemControl,
    HPCollectionViewControl
} HPControlType;

+ (void) setScreenName:(UIViewController*)vc screenName:(NSString*)name;
+ (void) setControlName:(UIView*)control controlName:(NSString*)controlName;
+ (void) setControlName:(UIView*)control controlName:(NSString*)controlName withScreenName:(NSString*)screenName;
+ (void) setControlType:(UIView*)control controlType:(HPControlType)type;
+ (void) addBreadcrumb:(NSString *)text;
+ (void) reportCrash: (NSException*) exception;
+ (void) reportHandledException:(NSException *)exception withDescription:(NSString *)description;
+ (void) reportHandledException:(NSException *)exception;
@end
