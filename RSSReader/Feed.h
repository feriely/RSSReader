//
//  Feed.h
//  RSSReader
//
//  Created by feriely on 14-4-12.
//  Copyright (c) 2014年 Coremail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Story;

@interface Feed : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) id icon;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSSet *stories;
@end

@interface Feed (CoreDataGeneratedAccessors)

- (void)addStoriesObject:(Story *)value;
- (void)removeStoriesObject:(Story *)value;
- (void)addStories:(NSSet *)values;
- (void)removeStories:(NSSet *)values;

@end
