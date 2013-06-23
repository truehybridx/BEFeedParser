//
//  BEFeedParser.m
//  beFeeder
//
//  Created by Brandon Etheredge on 3/19/12.
//  Copyright (c) 2012 Adlez Microsystems. All rights reserved.
//

#import "BEFeedParser.h"
#import "BEArticle.h"
#import "BEComment.h"
#import "AFJSONRequestOperation.h"
#import "NSString+HTML.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"


@interface BEFeedParser () {

}

// Article Parsing
- (void)articlesDownloadSuccessful:(id)data;
- (void)articlesDownloadFailed;

// Single Article Parsing
- (void)singleArticleDownloadSuccessful:(id)data;
- (void)singleArticleDownloadFailed;

// Comment Parsing
- (void)commentDownloadSuccessful:(id)data;
- (void)commentDownloadFailed;

// Comment Posting
- (void)commentPostSuccess;
- (void)commentPostFailed;

@end


@implementation BEFeedParser
@synthesize delegate;




// Article Parsing
-(void)downloadArticlesWithURL:(NSURL*)url
{

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request 
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            [self articlesDownloadSuccessful:JSON];
                                                                                        } 
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"Download failed!");
                                                                                        }];
    [operation start];
}


- (void)articlesDownloadSuccessful:(id)data
{
    
    // Create our container array
    NSMutableArray *array = [[NSMutableArray alloc] init];

    // Temporary array with the posts to be processed
    NSArray *arr1 = [data objectForKey:@"posts"];


    // Process Posts
    for (NSDictionary* element in arr1) {
        
        
        NSString *postID = [[element objectForKey:@"id"] stringValue];
        NSString *postTitle = [[element objectForKey:@"title"] stringByConvertingHTMLToPlainText];
        NSString *postContent = [element objectForKey:@"content"];
        NSString *postThumbnail = [element objectForKey:@"thumbnail"];
        NSString *postURL = [element objectForKey:@"url"];
        NSString *postAuthor = [[element objectForKey:@"author"] objectForKey:@"name"];
        NSString *postCommentCount = [[element objectForKey:@"comment_count"] stringValue];
        

        
        BEArticle *post = [[BEArticle alloc] initWithId:postID 
                                                  title:postTitle 
                                                content:postContent 
                                                    url:postURL 
                                              thumbnail:postThumbnail 
                                                 author:postAuthor 
                                           commentCount:postCommentCount];
        
        [array addObject:post];
        [post release];
        
    }
    
    // Send the array to the delegate
    NSArray *retArray = [[array copy] autorelease];
    [array release];
    [delegate articlesDownloaded:retArray];

}


- (void)articlesDownloadFailed
{
    
}

// Single Article Parsing
-(void)downloadSingleArticleWithURL:(NSURL*)url
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request 
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            [self singleArticleDownloadSuccessful:JSON];
                                                                                        } 
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"Download failed!");
                                                                                        }];
    [operation start];
}

- (void)singleArticleDownloadSuccessful:(id)data
{
    
    NSDictionary *rawArticle = [data objectForKey:@"post"];
    
    NSString *postID = [[rawArticle objectForKey:@"id"] stringValue];
    NSString *postTitle = [[rawArticle objectForKey:@"title"] stringByConvertingHTMLToPlainText];
    NSString *postContent = [rawArticle objectForKey:@"content"];
    NSString *postThumbnail = [rawArticle objectForKey:@"thumbnail"];
    NSString *postURL = [rawArticle objectForKey:@"url"];
    NSString *postAuthor = [[rawArticle objectForKey:@"author"] objectForKey:@"name"];
    
    
    // Add to a dictionary
//    NSDictionary *post = [[[NSDictionary alloc] initWithObjectsAndKeys:
//                          postID, @"id",
//                          postTitle, @"title",
//                          postContent, @"content",
//                          postURL, @"url",
//                          postThumbnail, @"thumbnail",
//                          postAuthor, @"author",
//                          //postCommentCount, @"comment_count",
//                           nil] autorelease];
    
    BEArticle *post = [[[BEArticle alloc] initWithId:postID 
                                              title:postTitle 
                                            content:postContent 
                                                url:postURL 
                                          thumbnail:postThumbnail 
                                              author:postAuthor 
                                        commentCount:@""] autorelease];
    
    
    [delegate singleArticleDownloaded:post];

    
}

- (void)singleArticleDownloadFailed
{
    
}

/*
 Use this to help
 NSString *jsonURL = [NSString stringWithFormat:@"%@%@", feedURL, @"?json=1&include=id,comments"];
 
 *****
 Comments may appear with UTF-8 Code characters.. clean up later
 
 */


// Comment Parsing
-(void)downloadCommentsWithURL:(NSURL*)url
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request 
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            [self commentDownloadSuccessful:JSON];
                                                                                        } 
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"Comment Download failed! %@", [error description]);
                                                                                        }];
    
    [operation start];
}

-(void)commentDownloadSuccessful:(id)data
{
        
    // Our Container
    NSMutableArray *commentArray = [[NSMutableArray alloc] init];
    
    // Raw Comment data
    NSArray *rawComments = [[data objectForKey:@"post"] objectForKey:@"comments"];
    
    for (NSDictionary *element in rawComments) {
        NSString *commentID = [element objectForKey:@"id"];
        NSString *commentName = [element objectForKey:@"name"];
        NSString *commentContent = [[element objectForKey:@"content"] stringByConvertingHTMLToPlainText];
        
        
        
        // Build Custom Dictionary
        BEComment *comment = [[BEComment alloc] initWithId:commentID author:commentName content:commentContent];
        
        [commentArray addObject:comment];
        [comment release];
        
    }
    
    // Make an Immutable Copy and send to delegate
    NSArray *retArray = [[commentArray copy] autorelease];
    [commentArray release];
    [delegate commentsDownloaded:retArray];
    
}

-(void)commentDownloadFailed
{
    
}

// Comment Posting
-(void)postCommentWithName:(NSString*)name email:(NSString*)email message:(NSString*)message url:(NSURL*)url postID:(NSString *)postID
{
    NSLog(@"%@\n%@\n%@\n%@\n%@", name, email, message, [url description], postID);
    
    #define kSendCommentJSON @"?json=respond.submit_comment"
    NSURL *completeURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [url description], kSendCommentJSON]];
    
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:completeURL];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            postID, @"post_id",
                            name, @"name",
                            email, @"email",
                            message, @"content", nil];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //
    }];
    
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Completed Successfullly");
        [self commentPostSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed misurable  %@", [error description]);
        [self commentPostFailed];
    }];
    
    [operation start];
    
}

- (void)commentPostSuccess
{
    [delegate commentPostedSuccessfully];
}

- (void)commentPostFailed
{
    [delegate commentFailedToPost];
}


@end
