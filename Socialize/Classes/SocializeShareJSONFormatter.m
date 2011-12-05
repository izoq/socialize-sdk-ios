//
//  SocializeShareJSONFormatter.m
//  SocializeSDK
//
//  Created by Fawad Haider on 7/1/11.
//  Copyright 2011 Socialize, Inc. All rights reserved.
//

#import "SocializeShareJSONFormatter.h"
#import "SocializeShare.h"
#import "JSONKit.h"
#import "SocializeObjectFactory.h"

@implementation SocializeShareJSONFormatter

-(void)doToObject:(id<SocializeObject>) toObject fromDictionary:(NSDictionary *)JSONDictionary
{
    id<SocializeShare> share = (id<SocializeShare>)toObject;
    
    [share setMedium:[[[JSONDictionary valueForKey:@"medium"] valueForKey:@"id"] intValue]];
    [share setText:[JSONDictionary valueForKey:@"text"]];
    [super doToObject:share fromDictionary:JSONDictionary];
}

@end