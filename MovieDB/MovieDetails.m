//
//  MovieDetails.m
//  MovieDB
//
//  Created by srujan.k on 09/11/17.
//

#import "MovieDetails.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"



@interface MovieDetails ()

@end

@implementation MovieDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.movieImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185/%@",self.movieDetails[@"poster_path"]]] placeholderImage:[UIImage imageNamed:@"default_poster"]];
    self.movieTitle.text =self.movieDetails[@"title"];
    self.ratings.text =[self.movieDetails[@"vote_average"] stringValue];
    self.synopsis.text =self.movieDetails[@"overview"];
    self.releaseDate.text =self.movieDetails[@"release_date"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
