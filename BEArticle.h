//
//  BEArticle.h
//  beFeeder
//
//  Created by Brandon Etheredge on 3/19/12.
//  Copyright (c) 2012 Adlez Microsystems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEArticle : NSObject {
    NSString *article_id;
    NSString *title;
    NSString *content;
    NSString *url;
    NSString *thumbnail;
    NSString *author;
    NSString *commentCount;
}

@property(nonatomic,retain) NSString *article_id;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *content;
@property(nonatomic,retain) NSString *url;
@property(nonatomic,retain) NSString *thumbnail;
@property(nonatomic,retain) NSString *author;
@property(nonatomic,retain) NSString *commentCount;

- (id)initWithId:(NSString*)articleId 
           title:(NSString*)articleTitle 
         content:(NSString*)articleContent 
             url:(NSString*)articleURL 
       thumbnail:(NSString*)articleThumbnail 
          author:(NSString*)articleAuthor 
    commentCount:(NSString*)articleCommentCount;

// Will return a NSDictionary with Key/Values as the variable names
// Dictionaries will be autoreleased
//
// Usage:
//  NSDictionary *dict = [myArticle dictionaryFromArticle];

- (NSDictionary*)dictionaryFromArticle;

// Will attempt to build an article from a properly formatted NSDictionary
// Oppisite of -dictionaryFromArticle
// Article will not be autoreleased
//
// Usage:
//  BEArticle *article = [[BEArticle alloc] initWithCompatibleDictionary:dict];

- (id)initWithCompatibleDictionary:(NSDictionary*)dictionary;

@end
