//
//  MovieView.h
//  MovieDB
//
//  Created by srujan.k on 09/11/17.
//

#import <Foundation/Foundation.h>
#import "ServerAPIDelegate.h"
#import "AFNetworking.h"

// URL's
#define API_KEY @"27f51783af2ac02df41688d75c213c6b"
#define BASE_URL @"https://api.themoviedb.org/3"
#define NOW_PLAYING @"/movie/now_playing"
#define POPULAR @"/movie/popular"
#define TOP_RATED @"/movie/top_rated"



@interface ServerAPI : NSObject
@property (weak, nonatomic) id <ServerAPIDelegate> delegate;

// URL's
@property (strong, nonatomic) NSMutableString *Base_url,*now_playing, *popular,*top_rated ;

-(void)getTopRated;
-(void)getPopular;
//-(void)getTopRated;


/*
-(void)loginUsingUserName:(NSString *)userName password:(NSString *)password locationID:(NSString *)locationID;

-(void)getProfileDetails:(NSString *)userID;
*/

@end
