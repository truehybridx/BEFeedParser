//
//  BEComment.m
//  beFeeder
//
//  Created by Brandon Etheredge on 3/19/12.
//  Copyright (c) 2012 Adlez Microsystems. All rights reserved.
//

#import "BEComment.h"

@implementation BEComment

@synthesize comment_Id;
@synthesize author;
@synthesize content;

- (id)initWithId:(NSString *)commentId author:(NSString *)commentAuthor content:(NSString *)commentContent {
    if ((self = [super init])) {
        self.comment_Id = commentId;
        self.author = commentAuthor;
        self.content = commentContent;
    }
    return self;
}

- (NSString *)description {
    NSString *ret = [NSString stringWithFormat:@"ID: %@  Author: %@", self.comment_Id, self.author];
    return ret;
}

- (void)dealloc {
    self.comment_Id = nil;
    self.author = nil;
    self.content = nil;
    [super dealloc];
}

@end
