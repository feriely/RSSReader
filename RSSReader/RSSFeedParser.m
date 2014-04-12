//
//  RSSFeedParser.m
//  RSSReader
//
//  Created by feriely on 14-4-12.
//  Copyright (c) 2014年 Coremail. All rights reserved.
//

#import <TFHpple.h>
#import "RSSFeedParser.h"

@interface RSSFeedParser ()
@property (nonatomic, strong) NSURL *feedURL;
@property (nonatomic, strong) TFHpple *document;
@end

@implementation RSSFeedParser

+ (NSDictionary *)parseFeedWithData:(NSData *)data link:(NSString *)link
{
    NSMutableDictionary *result = nil;

    if (data) {
        result = [[NSMutableDictionary alloc] init];
        
        TFHpple *document = [[TFHpple alloc] initWithXMLData:data];
        TFHppleElement *element = [[document searchWithXPathQuery:@"//channel"] firstObject];
        
        // Add channel link
        [result setObject:link forKey:kLinkElementName];
        
        // Add channel title
        [result setObject:[[element firstChildWithTagName:kTitleElementName] text] forKey:kTitleElementName];
        
        // Add channel description
        [result setObject:[[element firstChildWithTagName:kDescriptionElementName] text] forKey:kDescriptionElementName];
        
        // Add stories
        NSArray *itemElements = [element childrenWithTagName:kItemElementName];
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (TFHppleElement *itemElement in itemElements) {
            NSString *itemTitle = [[itemElement firstChildWithTagName:kTitleElementName] text];
            NSString *itemLink = [[itemElement firstChildWithTagName:kLinkElementName] text];
            TFHppleElement *descElement = [itemElement firstChildWithTagName:kDescriptionElementName];
            NSString *itemDescription = [[descElement firstChild] content];
            TFHpple *descriptionDocument = [[TFHpple alloc] initWithHTMLData:[itemDescription dataUsingEncoding:NSUTF8StringEncoding]];
            NSArray *elements = [descriptionDocument searchWithXPathQuery:@"//a"];
            if (elements.count) {
                TFHppleElement *element = [elements firstObject];
                itemDescription = [element text];
            }
            [items addObject:@{ kTitleElementName : itemTitle,
                                kLinkElementName : itemLink,
                                kDescriptionElementName : itemDescription }];
        }
        [result setObject:items forKey:kItemElementName];
    }
    
    return [result copy];
}

@end
