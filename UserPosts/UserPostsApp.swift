import SwiftUI

@main
struct UserPostsApp: App {
    @StateObject private var router = AppRouter()
        
    private let movieToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmVjOGFiOTM0ZmQxMmFhMTlkOTU2Mjc3MGJlYTEzMyIsIm5iZiI6MTc2ODY1Mjc0NC41ODQsInN1YiI6IjY5NmI3ZmM4YzNjOTEzYjU4NzIwYzZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ggy9tOH_VSmqt2Y1J7LN8_4_YlSCiLUCE7zPt2j7rvY"
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                makeOnBoaringView()
                    .navigationDestination(for: Route.self) { route in
                        makeView(for: route)
                    }
            }
            .environmentObject(router)
        }
    }

    private func makeHomeView() -> HomeView {
        let dataSource = MovieRemoteDataSourceImpl(token: movieToken)
        let repository: MovieRepository = MovieRepositoryImpl(remoteDataSource: dataSource)
        let useCase = DefaultGetAllMoviesUseCase(repository: repository)
        let viewModel = HomeViewModel(searchUseCase: useCase, appRouter: router)
        return HomeView(viewModel: viewModel)
    }

    private func makeDetailsView(id: Int) -> DetailsScreen {
        let dataSource = MovieRemoteDataSourceImpl(token: movieToken)
        let repository: MovieRepository = MovieRepositoryImpl(remoteDataSource: dataSource)
        let useCase = DefaultGetMovieDetailsUseCase(repository: repository)
        let viewModel = DetailsViewModel(movieDetialsUseCase: useCase, appRouter: router)
        return DetailsScreen(moviewID: id,viewModel: viewModel)
      }

    private func makeOnBoaringView() -> OnBoaringScreen {
        OnBoaringScreen {
            router.navigate(to: .HomeScreen)
        }
    }

    @ViewBuilder
    private func makeView(for route: Route) -> some View {
        switch route {
        case .OnBoardingScreen:
            makeOnBoaringView()

        case .HomeScreen:
            makeHomeView()

        case .DetailsScreen(let id):
            makeDetailsView(id: id)
        }
    }
}
