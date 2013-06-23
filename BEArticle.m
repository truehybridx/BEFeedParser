//
//  BEArticle.m
//  beFeeder
//
//  Created by Brandon Etheredge on 3/19/12.
//  Copyright (c) 2012 Adlez Microsystems. All rights reserved.
//

#import "BEArticle.h"

@implementation BEArticle

@synthesize article_id;
@synthesize title;
@synthesize content;
@synthesize url;
@synthesize thumbnail;
@synthesize author;
@synthesize commentCount;

- (id)initWithId:(NSString *)articleId title:(NSString *)articleTitle content:(NSString *)articleContent url:(NSString *)articleURL thumbnail:(NSString *)articleThumbnail author:(NSString *)articleAuthor commentCount:(NSString *)articleCommentCount {
    
    if ((self = [super init])) {
        self.article_id = articleId;
        self.title = articleTitle;
        self.content = articleContent;
        self.url = articleURL;
        self.thumbnail = articleThumbnail;
        self.author = articleAuthor;
        self.commentCount = articleCommentCount;
    }
    return self;
}

- (NSDictionary*)dictionaryFromArticle
{
    // Decided to not save the comment count when going to Dictionary
    // It can change so theres no point in caring about it.
    // This is mainly used for Archiving or saving the Article
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.article_id, @"article_id",
                           self.title, @"title",
                           self.content, @"content",
                           self.url, @"url",
                           self.thumbnail, @"thumbnail",
                           self.author, @"author",
                           nil];
    
    return dict;
    
}

- (id)initWithCompatibleDictionary:(NSDictionary*)dictionary
{
    return [self initWithId:[dictionary objectForKey:@"article_id"] 
                      title:[dictionary objectForKey:@"title"] 
                    content:[dictionary objectForKey:@"content"] 
                        url:[dictionary objectForKey:@"url"] 
                  thumbnail:[dictionary objectForKey:@"thumbnail"] 
                     author:[dictionary objectForKey:@"author"] 
               commentCount:@"0"]; 
   
}

- (NSString *)description {
    NSString *ret = [NSString stringWithFormat:@"\nTitle: %@ \nAuthor: %@ \nURL: %@", self.title, self.author, self.url];
    return ret;
}


- (void) dealloc {
 
    self.article_id = nil;
    self.title = nil;
    self.content = nil;
    self.url = nil;
    self.thumbnail = nil;
    self.author = nil;
    self.commentCount = nil;
    [super dealloc];
}

@end
