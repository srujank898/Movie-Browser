//
//  MovieView.h
//  MovieDB
//
//  Created by srujan.k on 09/11/17.
//

#import <Foundation/Foundation.h>

@protocol ServerAPIDelegate <NSObject>

@optional

#pragma mark - Top Rated
-(void)topRatedListSucess:(NSArray *)response;
-(void)topRatedListError:(NSError *)error;

#pragma mark - User Login
-(void)popularListSucess:(NSArray *)response;
-(void)popularListError:(NSError *)error;

#pragma mark - User Profile
-(void)userGetProfileSucess:(NSDictionary *)response;
-(void)userGetProfileError:(NSError *)error;

@end
