# BEFeedParser - Wordpress JSON Processor for iOS

Loosely based off the idea behind MWFeedParser
https://github.com/mwaterfall/MWFeedParser

## Features

* Easily download Wordpress articles to represent in your application.
* Post comments from within your application. (Only tested on default Wordpress comments)
* iOS and Mac Capable (Uses AFNetworking which is compatible with both platforms)

## Requirements for WebSite

* Wordpress
* JSON API for Wordpress


## Required Libraries

* AFNetworking
	https://github.com/AFNetworking/AFNetworking
* SBJSON (For pre-iOS 5)
	https://github.com/stig/json-framework


## Usage

1. Set your object as a BEFeedParserDelegate  

2. Implement the following delegate methods:  
    ```objc
    // Called on delegate giving it an array of article objects  
    -(void)articlesDownloaded:(NSArray*)articles;  
    // Called on delegate giving it a single article object  
    -(void)singleArticleDownloaded:(id)article;  
    // Called on delegate giving it an array of comment objects  
    -(void)commentsDownloaded:(NSArray*)comments;  
    // Called on failure or success of posting comments  
    -(void)commentFailedToPost;  
    -(void)commentPostedSuccessfully;  
    ```
3. Create and allocate a BEFeedParser object:  
    ```objc
    BEFeedParser *parser = [[BEFeedParser alloc] init];  
    ```
4. Set the delegate:   
    ```objc
    parser.delegate = self;
    ```
5. Call one of the following with a URL to the JSON API (http://wordpress.com/?json=1)  
    ```objc
    // Downloads articles, then calls [delegate articlesDownloaded:]
    [parser downloadArticlesWithURL:url];
    // Downloads single article, then calls [delegate singleArticleDownloaded:]
    [parser downloadSingleArticleWithURL:url];
    // Downloads comments, then calls [delegate commentsDownloaded:]
    [parser downloadCommentsWithURL:url];
    ```
* If you experience weirdness, check what is returned by opening a web browser to: yoursite.com/?json=1

TIP: In the apps I use this in, I used the following string appended to the website URL + a page number so more articles can be downloaded later.  
    ```
    "?json=1&include=title,author,status,thumbnail,url,content,comment_count&count=10&page="
    ```

## Send comments

1. Create a BEFeedParser object
2. Call the function, passing the URL of the article to comment on  
    ```objc
    [feedParser postCommentWithName:@"Name" email:@"Email" message:@"A Message" url:urlOfPost postID:idOfThePost
    ```

## Data Structures

BEArticle - object representing a Wordpress Article  

Data:  
- NSString *article_id;  
- NSString *title;	// This may contain HTML.  
- NSString *content;	// This contains raw HTML from the article.  
- NSString *url;
- NSString *thumbnail;	// This contains the link to the Featured Image.  
- NSString *author;  
- NSString *commentCount;  



BEComment - object representing a Wordpress Comment  

Data:  
- NSString *comment_Id;  
- NSString *author;  
- NSString *content;	// This contains raw HTML from the comment.  

* HTML is left in case you want the styling as it appears on the website. GoogleToolBox has functions that will strip HTML from the string.

## Closing

At this time, I have nothing more I would like to add to this library, however it is open to anyone who wants to add and expand on it.
