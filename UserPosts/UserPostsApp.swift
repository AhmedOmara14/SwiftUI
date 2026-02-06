//
//  UserPostsApp.swift
//  UserPosts
//
//  Created by Omara on 10/01/2026.
//

import SwiftUI

@main
struct UserPostsApp: App {
    @StateObject private var router = AppRouter()
        
    private let movieToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmVjOGFiOTM0ZmQxMmFhMTlkOTU2Mjc3MGJlYTEzMyIsIm5iZiI6MTc2ODY1Mjc0NC41ODQsInN1YiI6IjY5NmI3ZmM4YzNjOTEzYjU4NzIwYzZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ggy9tOH_VSmqt2Y1J7LN8_4_YlSCiLUCE7zPt2j7rvY"
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                makeSearchView()
                    .navigationDestination(for: Route.self) { route in
                        makeView(for: route)
                    }
            }
            .environmentObject(router)
        }
    }
        
    private func makeSearchView() -> SearchView {
        let dataSource = MovieRemoteDataSourceImpl(token: movieToken)
        let repository: MovieRepository = MovieRepositoryImpl(remoteDataSource: dataSource)
        let useCase = DefaultSearchMoviesUseCase(repository: repository)
        let viewModel = SearchViewModel(searchUseCase: useCase, appRouter: router)
        return SearchView(viewModel: viewModel)
    }
    
    
    private func makeDetailsView(id: Int) -> DetailsScreen {
        return DetailsScreen(moviewID: id)
    }
    
    @ViewBuilder
    private func makeView(for route: Route) -> some View {
        switch route {
        case .HomeScreen:
            makeSearchView()
            
        case .DetailsScreen(let id):
            makeDetailsView(id: id)
        }
    }
}
