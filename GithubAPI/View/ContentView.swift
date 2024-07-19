//
//  ContentView.swift
//  GithubAPI
//
//  Created by admin on 7/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var gitHubUser: GithubUser = GithubUser(name: "", avatar_url: "", bio: "")
    var networkCall: NetworkCall
    @State private var username: String = ""
    
    var body: some View {
        if networkCall.isLoading{
            ProgressView()
        }else{
            
            VStack(spacing: 20) {
                HStack {
                    TextField("Enter username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                    Button(action: {
                        Task {
                           gitHubUser = await networkCall.loadPosts(username: username)
                        }
                    }) {
                        Text("Generate")
                            .padding(8)
                            .background(Color.white)
                            .opacity(0.9)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                Text("GitHub Card Generator").bold()
                    .font(.system(size: 32))
                    .fontDesign(.serif)
                    .foregroundColor(.white)
                
                Spacer()
                if networkCall.isLoading{
                    VStack{
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(3)
                    }
                    Spacer()
                }
                else{
                    if gitHubUser.name != "" {
                        VStack{
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    .frame(width:190, height:190)
                                AsyncImage(url: URL(string: gitHubUser.avatar_url)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                } placeholder: {
                                    
                                }.frame(width: 180, height:180)
                                   
                            }.padding(.bottom,40)
                            Text(gitHubUser.name).bold()
                                .lineLimit(1)
                                .font(.title)
                                .truncationMode(.tail)
                                .foregroundColor(.white)
                            Text(gitHubUser.bio)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }.padding(10)
                        .frame(width: 350, height: 450)
                            .background(Color.white.opacity(0.05))
                        .overlay( RoundedRectangle(cornerRadius: 10) // Outline shape
                                .stroke(Color.white, lineWidth: 2) // Outline color and width
                                   )
                        
                        
                    }else{
                        Text("No Search Result").bold()
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }.padding()
                .background(Color.customBlue)
        }
    }
}



class MockNetworkCall: NetworkCall {
    func getUser1() async -> GithubUser {
        return GithubUser( name: "Ali", avatar_url: "none", bio: "iOS Developer")
    }
}

extension Color{
    static let customBlue = Color(red: 0.314, green: 0.549, blue: 0.608)

}

#Preview {
    ContentView(gitHubUser: GithubUser(name: "", avatar_url: "", bio: ""), networkCall: MockNetworkCall())
}
