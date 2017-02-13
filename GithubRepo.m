//
//  GithubRepo.h
//  crazybaby_test
//
//  Created by Walnut Tech on 10/2/17.
//  Copyright © 2017年 MaoJian. All rights reserved.
//

#import "GithubRepo.h"
//#import <AFNetworking.h>
//#import "AFHTTPRequestOperationManager.h"
#import "GithubRepoSearchSettings.h"

@interface GithubRepo ()
@end

@implementation GithubRepo

static NSString * const kReposUrl = @"https://api.github.com/search/repositories";//https://api.github.com/graphql //https://api.github.com/search/repositories
static NSString * const kClientId = nil;
static NSString * const kClientSecret = nil;

- (void)initializeWithDictionary:(NSDictionary *)jsonResult {
    self.name = jsonResult[@"name"];
    self.stars = [jsonResult[@"stargazers_count"] integerValue];
    self.forks = [jsonResult[@"forks_count"] integerValue];
    self.ownerHandle = jsonResult[@"owner"][@"login"];
    self.ownerAvatarURL = jsonResult[@"owner"][@"avatar_url"];
    self.repoDescription = jsonResult[@"description"];
    self.htmlurl = jsonResult[@"html_url"];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    GithubRepo *copy = [[[self class] alloc] init];

    if (copy) {
        copy.name = self.name;
        copy.ownerHandle = self.ownerHandle;
        copy.ownerAvatarURL = self.ownerAvatarURL;
        copy.stars = self.stars;
        copy.forks = self.forks;
    }

    return copy;
}

+ (void)fetchRepos:(GithubRepoSearchSettings *)settings successCallback:(void(^)(NSArray *))successCallback {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (kClientId) {
        [params setObject:kClientId forKey:@"client_id"];
    }
    if (kClientSecret) {
        [params setObject:kClientSecret forKey:@"client_secret"];
    }
    
    NSMutableString *query = [[NSMutableString alloc] initWithString:@""];
    if (settings.searchString) {
        [query appendString:settings.searchString];
    }
    //[query appendString:[NSString stringWithFormat:@" stars:>%ld", settings.minStars]];
    
    [params setObject:query forKey:@"q"];
    [params setObject:@"stars" forKey:@"sort"];
    [params setObject:@"desc" forKey:@"order"];
    
    NSString *aString = [NSString stringWithFormat:@"%@?q=%@", kReposUrl,query];
    
    //NSString *aString = [NSString stringWithFormat:@"%@?query={repo(repo:""%@""){repo}", kReposUrl,query];
    
    NSString *newStr = [aString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:newStr];
    NSLog(@"githubdebug11 %@  %@",url,query);
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
//    NSDictionary *headers = [request allHTTPHeaderFields];
//
//    [headers setValue:@"beahelllrer 953890c7c08542c2725b6b1337719ae9be27c4d6" forKey:@"Authorization"];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            //NSLog(@"githubdebug22 %@",dict);
            
            NSArray *results = dict[@"items"];

            NSMutableArray *repos = [[NSMutableArray alloc] init];
            for (NSDictionary *result in results) {
                GithubRepo *repo = [[GithubRepo alloc] init];
                [repo initializeWithDictionary:result];
                [repos addObject:repo];
            }
            NSLog(@"githubdebug22 %@",repos);

            successCallback(repos);
            

        }
    }];
    
    //5.执行任务
    [dataTask resume];
    
    
    
    
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    [manager GET:kReposUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSArray *results = responseObject[@"items"];
//        if (results) {
//            NSMutableArray *repos = [[NSMutableArray alloc] init];
//            for (NSDictionary *result in results) {
//                GithubRepo *repo = [[GithubRepo alloc] init];
//                [repo initializeWithDictionary:result];
//                [repos addObject:repo];
//            }
//            successCallback(repos);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failure while trying to fetch repos");
//    }];
}



- (NSString *)description {
    return [NSString stringWithFormat:@"\n\tName: %@\n\tStars: %ld\n\tForks: %ld\n\tOwner: %@\n\tAvatar: %@\n\tDescription: %@\n\thtmlUrl: %@\n\t",
            self.name,
            self.stars,
            self.forks,
            self.ownerHandle,
            self.ownerAvatarURL,
            self.repoDescription,
            self.htmlurl];
}

@end
