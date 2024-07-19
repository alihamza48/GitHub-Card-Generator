//
//  GithubAPIApp.swift
//  GithubAPI
//
//  Created by admin on 7/19/24.
//

import SwiftUI

@main
struct GithubAPIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(gitHubUser: GithubUser(name: "", avatar_url: "", bio: ""), networkCall: MockNetworkCall())
        }
    }
}
