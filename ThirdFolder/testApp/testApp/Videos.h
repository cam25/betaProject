//
//  Videos.h
//  testApp
//
//  Created by Cameron Mozie on 8/15/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Videos : NSObject
{
     NSURL *moviesURL;
    NSString *movieName;
    NSString *authorMovie;
}
-(id)initWithTitle:(NSURL*)videos videoTitle:(NSString*)movieTitle authorName:(NSString*)author;
@property(nonatomic,strong)NSURL *moviesURL;
@property(nonatomic,strong)NSString *movieName;
@property(nonatomic,strong)NSString *authorMovie;

@end
