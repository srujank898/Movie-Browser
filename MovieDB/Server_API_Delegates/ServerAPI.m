//
//  MovieView.h
//  MovieDB
//
//  Created by srujan.k on 09/11/17.
//

#import "ServerAPI.h"
#import "ServerAPIDelegate.h"

@implementation ServerAPI
@synthesize Base_url,now_playing,popular,top_rated;
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Base_url = [NSMutableString stringWithString:BASE_URL];
        self.top_rated = [NSMutableString stringWithString:TOP_RATED];
        
    }
    return self;
}
#pragma mark - Login
-(void)getTopRated{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@?api_key=%@",BASE_URL,TOP_RATED,API_KEY];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"resoonse:%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self.delegate topRatedListSucess:responseObject[@"results"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
        [self.delegate topRatedListError:error];
    }];
}
-(void)getPopular{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@?api_key=%@",BASE_URL,POPULAR,API_KEY];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"resoonse:%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self.delegate popularListSucess:responseObject[@"results"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
        [self.delegate popularListError:error];
    }];
}
-(void)searchUsingMovieName:(NSString *)movieQuery{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *urlString = [movieQuery stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];

    NSString *url = [NSString stringWithFormat:@"%@%@?api_key=%@&query=%@",BASE_URL,SEARCH_MOVIE,API_KEY,urlString];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"resoonse:%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self.delegate searchMovieSucess:responseObject[@"results"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
        [self.delegate searchMovieError:error];
    }];
}


@end
