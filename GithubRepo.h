//
//  GithubRepo.h
//  crazybaby_test
//
//  Created by Walnut Tech on 10/2/17.
//  Copyright © 2017年 MaoJian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GithubRepoSearchSettings;

@interface GithubRepo : NSObject <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ownerHandle;
@property (nonatomic, strong) NSString *ownerAvatarURL;
@property (nonatomic, strong) NSString *htmlurl;
@property (nonatomic, strong) NSString *repoDescription;
@property NSInteger stars;
@property NSInteger forks;



+ (void)fetchRepos:(GithubRepoSearchSettings *)settings successCallback:(void(^)(NSArray *))successCallback;

@end
