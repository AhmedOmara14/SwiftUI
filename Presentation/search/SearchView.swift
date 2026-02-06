//
//  SearchView.swift
//  UserPosts
//
//  Created by Omara on 30/01/2026.
//
import SwiftUI

struct SearchView: View {
    @StateObject private var vm: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }
    
    static func create(router: AppRouter) -> SearchView {
        let dataSource = MovieRemoteDataSourceImpl(
            token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmVjOGFiOTM0ZmQxMmFhMTlkOTU2Mjc3MGJlYTEzMyIsIm5iZiI6MTc2ODY1Mjc0NC41ODQsInN1YiI6IjY5NmI3ZmM4YzNjOTEzYjU4NzIwYzZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ggy9tOH_VSmqt2Y1J7LN8_4_YlSCiLUCE7zPt2j7rvY"
        )
        let repo = MovieRepositoryImpl(remoteDataSource: dataSource)
        let useCase = DefaultSearchMoviesUseCase(repository: repo)
        let viewModel = SearchViewModel(searchUseCase: useCase,appRouter: router)
        
        return SearchView(viewModel: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            switch vm.state {
            case .idle:
                ProgressView("Loading…")
                
            case .loading:
                ProgressView("Loading…")
                
            case .loaded(let movies):
                if !movies.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(movies) { movie in
                                MovieCardInfo(movie: movie){movie in
                                    vm.navigateToDetails(movie: movie)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("No movies found")
                        .foregroundColor(.gray)
                }
                
            case .failure(let error):
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("Error loading movies")
                        .font(.headline)
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        }
        .navigationTitle("Search Movies")
    }
}
