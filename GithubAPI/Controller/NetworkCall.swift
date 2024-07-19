//
//  NetworkCall.swift
//  GithubAPI
//
//  Created by admin on 7/19/24.
//

import Foundation

class NetworkCall{
    @Published var isLoading = false
    
    func loadPosts(username: String) async -> GithubUser{
           isLoading = true

               let posts = await getUser(username: username)
              print(posts)
           isLoading = false
            return posts
       }
    
    func getUser(username: String) async -> GithubUser {
        
        let accessToken = "Your_Access_Key"
        var post = GithubUser(name: "", avatar_url: "", bio: "")
        let url = "https://api.github.com/users/\(username)"
        let urlString = URL(string: url)
        
        do{
            
            var request = URLRequest(url: urlString!)
                   request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
                   
            let (data,response) = try await URLSession.shared.data(from: urlString!)
        
        if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            
            do{
                let decoder = JSONDecoder()
                 post = try decoder.decode(GithubUser.self, from: data)
               
            }catch{
                print(error.localizedDescription)
            }
        }
        }catch{
            print(error.localizedDescription)
        }
        return post
    }
    
    
}

//enum GHError: Error {
//    case noURL
//    case falseResponse
//    case invalidData
//}
