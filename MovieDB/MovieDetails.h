//
//  MovieDetails.h
//  MovieDB
//
//  Created by srujan.k on 09/11/17.
//

#import <UIKit/UIKit.h>

@interface MovieDetails : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *movieImage;
@property (strong, nonatomic) IBOutlet UILabel *movieTitle;
@property (strong, nonatomic) IBOutlet UILabel *ratings;
@property (strong, nonatomic) IBOutlet UILabel *releaseDate;
@property (strong, nonatomic) IBOutlet UITextView *synopsis;
@property(strong, nonatomic) NSMutableDictionary *movieDetails;

@end
