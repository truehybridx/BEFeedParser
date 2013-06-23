/*
//  BEFeedParser.h
//  beFeeder
//
//  Created by Brandon Etheredge on 3/19/12.
//  Copyright (c) 2012 Adlez Microsystems. All rights reserved.
//
//  Required Libraries:
//        AFNetworking
//        SBJson
//        Google Toolbox for Mac      (Provided)
//        NSString+HTML               (Provided)
//
//  Required for WebSite:
//        Wordpress JSON API
//        Thumbnail Plugin
//
//  Article objects have the following data:
//  article_id - String which is the Wordpress ID number
//  title - String which is the Title of the article
//  content - String of the HTML content
//  url - String which is the URL to the article
//  thumbnail - String which is the URL to the article's featured image
//  author - String of the Author's name
//  commentCount - String of the number of comments on article
//
//
//  Comment objects have the following data:
//  comment_Id - String of the Wordpress ID
//  author - String of the name of the commenter
//  content - String of the HTML content
//
//  For Comments to be posted Respond must be activated in the
//  Wordpress JSON API
//
//
//
//  USAGE: Create a BEFeedParser object. It's delegate (you) must implement one of the
//  optional Delegate Methods below to recived the downloaded data.
//
//  // Allocate out feedParser
//  feedParser = [[BEFeedParser alloc] init];
// 
//  // Set our feedParser Delegate
//  feedParser.delegate = self;
//
//  // Call a download method USING a URL with the ?json=1 extension
//  [feedParser downloadArticlesWithURL:url];
//
//  DELEGATE METHODS:
//
//  Will return a processed array of Article Objects you can use in your app (BEArticle)
//  -(void)articlesDownloaded:(NSArray*)articles;
//
//  Will return a single Article Object (BEArticle)
//  -(void)singleArticleDownloaded:(id)article;
//
//  Will return a processed array of Comment Objects (BEComment)
//  -(void)commentsDownloaded:(NSArray*)comments;
//
//  Will be called if a comment fails to post
//  -(void)commentFailedToPost;
//
//  Will be called if a comment posted successfully
//  -(void)commentPostedSuccessfully;
//
// 
*/
 
 
#import <Foundation/Foundation.h>

@protocol BEFeedParserDelegate <NSObject>

@optional
// Downloaded Data Delegate Methods
-(void)articlesDownloaded:(NSArray*)articles;
-(void)singleArticleDownloaded:(id)article;
-(void)commentsDownloaded:(NSArray*)comments;

// Comment Posting Delegate Methods
-(void)commentFailedToPost;
-(void)commentPostedSuccessfully;

@end

@interface BEFeedParser : NSObject {
    id <BEFeedParserDelegate> delegate;
}

@property (assign) id delegate;


// Download Data Methods
-(void)downloadArticlesWithURL:(NSURL*)url;
-(void)downloadSingleArticleWithURL:(NSURL*)url;
-(void)downloadCommentsWithURL:(NSURL*)url;

// Post Comment Method
-(void)postCommentWithName:(NSString*)name email:(NSString*)email message:(NSString*)message url:(NSURL*)url postID:(NSString*)postID;

@end


