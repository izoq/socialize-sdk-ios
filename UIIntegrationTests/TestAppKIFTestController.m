//
//  SampleKIFTestController.m
//  SocializeSDK
//
//  Created by Nathaniel Griswold on 9/14/11.
//  Copyright 2011 Socialize, Inc. All rights reserved.
//

#import "TestAppKIFTestController.h"
#import "KIFTestScenario+TestAppAdditions.h"
#import "StringHelper.h"

static NSString *UUIDString() {
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);
    NSString	*uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [uuidString autorelease];
}

static NSString *TestAppKIFTestControllerRunID = nil;

@implementation TestAppKIFTestController

+(NSDictionary*)authInfoFromConfig
{
    NSBundle * bundle =  [NSBundle bundleForClass:[self class]];
    NSString * configPath = [bundle pathForResource:@"SocializeApiInfo" ofType:@"plist"];
    NSDictionary * configurationDictionary = [[[NSDictionary alloc]initWithContentsOfFile:configPath] autorelease];
    return  [configurationDictionary objectForKey:@"Socialize API info"];
}

+ (void)enableValidFacebookSession {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *apiInfo = [self authInfoFromConfig];
    if ([apiInfo objectForKey:@"facebookToken"]) {
        [defaults setObject:[apiInfo objectForKey:@"facebookToken"] forKey:@"FBAccessTokenKey"];
        [defaults setObject:[NSDate distantFuture] forKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}
                             
+ (void)disableValidFacebookSession {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}
                   

- (void)initializeScenarios;
{
    [self addScenario:[KIFTestScenario scenarioToTestActionBar]];
    [self addScenario:[KIFTestScenario scenarioToTestUserProfile]];
    [self addScenario:[KIFTestScenario scenarioToTestFacebookAuth]];
    [self addScenario:[KIFTestScenario scenarioToTestTwitterAuth]];
    [self addScenario:[KIFTestScenario scenarioToTestLikeNoAuth]];
    [self addScenario:[KIFTestScenario scenarioToTestLikeTwitterAuth]];
    [self addScenario:[KIFTestScenario scenarioToTestDirectURLNotification]];
    [self addScenario:[KIFTestScenario scenarioToTestLikeButton]];
//    [self addScenario:[KIFTestScenario scenarioToTestComposeCommentFacebookAuth]];
//    [self addScenario:[KIFTestScenario scenarioToTestComposeCommentTwitterAuth]];
    [self addScenario:[KIFTestScenario scenarioToTestComposeCommentNoAuth]];
    [self addScenario:[KIFTestScenario scenarioToTestCommentsList]];
    [self addScenario:[KIFTestScenario scenarioToTestProgrammaticNotificationDismissal]];
}

+ (NSString*)runID {
    if (TestAppKIFTestControllerRunID == nil) {
        NSString *uuid = UUIDString();
        NSString *sha1 = [uuid sha1];
        NSString *runID = [sha1 substringToIndex:8];
        
        TestAppKIFTestControllerRunID = runID;
    }
    
    return TestAppKIFTestControllerRunID;
}

+ (NSString*)testURL:(NSString*)suffix {
    return [NSString stringWithFormat:@"http://itest.%@/%@", [self runID], suffix];
}

@end
