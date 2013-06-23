//
//  BEComment.h
//  beFeeder
//
//  Created by Brandon Etheredge on 3/19/12.
//  Copyright (c) 2012 Adlez Microsystems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEComment : NSObject {
    NSString *comment_Id;
    NSString *author;
    NSString *content;
}

@property(nonatomic,retain) NSString *comment_Id;
@property(nonatomic,retain) NSString *author;
@property(nonatomic,retain) NSString *content;

-(id)initWithId:(NSString*)commentId author:(NSString*)commentAuthor content:(NSString*)commentContent;

@end
