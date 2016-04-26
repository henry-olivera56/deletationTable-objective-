//
//  Delegation.h
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Member;

@interface Delegation : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * arrivaldate;
@property (nonatomic, retain) NSDate * backdate;
@property (nonatomic, retain) NSSet *members;
@end

@interface Delegation (CoreDataGeneratedAccessors)

- (void)addMembersObject:(Member *)value;
- (void)removeMembersObject:(Member *)value;
- (void)addMembers:(NSSet *)values;
- (void)removeMembers:(NSSet *)values;

@end
