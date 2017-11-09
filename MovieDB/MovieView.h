//
//  MovieView.h
//  MovieDB
//
//  Created by srujan.k on 09/11/17.
//

#import <UIKit/UIKit.h>
#import "ServerAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieDetails.h"
#import "UIImageView+WebCache.h"


@interface MovieView : UIViewController<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, ServerAPIDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;

@end
