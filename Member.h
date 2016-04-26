//
//  Member.h
//  DelegationTable
//
//  Created by DODOBAL-1 on 11/16/15.
//  Copyright (c) 2015 DODOBAL-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Delegation;

@interface Member : NSManagedObject

@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * fatherjob;
@property (nonatomic, retain) NSString * fathername;
@property (nonatomic, retain) NSString * job;
@property (nonatomic, retain) NSString * motherjob;
@property (nonatomic, retain) NSString * mothername;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * org;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSString * university;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) Delegation *delegation;

@end
