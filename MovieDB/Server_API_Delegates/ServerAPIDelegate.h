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

#pragma mark - Popular List
-(void)popularListSucess:(NSArray *)response;
-(void)popularListError:(NSError *)error;

#pragma mark - Popular List
-(void)searchMovieSucess:(NSArray *)response;
-(void)searchMovieError:(NSError *)error;


@end
