//
//  UserPostsApp.swift
//  UserPosts
//
//  Created by Omara on 10/01/2026.
//

import SwiftUI

@main
struct UserPostsApp: App {
    
    var body: some Scene {
        WindowGroup {
            let dataSource = MovieRemoteDataSourceImpl(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmVjOGFiOTM0ZmQxMmFhMTlkOTU2Mjc3MGJlYTEzMyIsIm5iZiI6MTc2ODY1Mjc0NC41ODQsInN1YiI6IjY5NmI3ZmM4YzNjOTEzYjU4NzIwYzZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ggy9tOH_VSmqt2Y1J7LN8_4_YlSCiLUCE7zPt2j7rvY")
            let repo = MovieRepositoryImpl(remoteDataSource: dataSource)
            let useCase = DefaultSearchMoviesUseCase(repository: repo)
            let viewModel = SearchViewModel(searchUseCase: useCase)
            
            SearchView(viewModel: viewModel)
            
        }
    }
}
