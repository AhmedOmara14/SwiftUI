import SwiftUI

struct HomeView: View {
    @StateObject private var vm: HomeViewModel
    
    @State private var currentIndex: Int = 0
    
    init(viewModel: HomeViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }
    
    static func create(router: AppRouter) -> HomeView {
        let dataSource = MovieRemoteDataSourceImpl(
            token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmVjOGFiOTM0ZmQxMmFhMTlkOTU2Mjc3MGJlYTEzMyIsIm5iZiI6MTc2ODY1Mjc0NC41ODQsInN1YiI6IjY5NmI3ZmM4YzNjOTEzYjU4NzIwYzZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ggy9tOH_VSmqt2Y1J7LN8_4_YlSCiLUCE7zPt2j7rvY"
        )
        let repo = MovieRepositoryImpl(remoteDataSource: dataSource)
        let useCase = DefaultGetAllMoviesUseCase(repository: repo)
        let viewModel = HomeViewModel(searchUseCase: useCase, appRouter: router)
        return HomeView(viewModel: viewModel)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.20, green: 0.13, blue: 0.42),
                    Color.black
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 14) {
                    SliderContent
                    
                    ForYouContent
                    
                    Spacer(minLength: 10)
                    
                }
                .padding(.top, 10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private var SliderContent: some View {
        switch vm.state {
        case .idle, .loading:
            ProgressView("Loading…")
                .foregroundStyle(.white)
            
        case .loaded(let movies):
            if movies.isEmpty {
                Text("No movies found")
                    .foregroundStyle(.white.opacity(0.6))
            } else {
                VStack {
                    AnimatedMovieSlider(
                        movies: movies,
                        currentIndex: $currentIndex,
                        onTap: { vm.navigateToDetails(movie: $0) }
                    )
                    
                    MovieInfoRow(movie: movies[currentIndex])
                        .padding(.horizontal, 18)
                    
                    Spacer().frame(height: 16)
                    
                    HStack(spacing: 8) {
                        ForEach(0..<min(movies.count, 10), id: \.self) { i in
                            Circle()
                                .frame(width: i == currentIndex ? 8 : 6, height: i == currentIndex ? 8 : 6)
                                .opacity(i == currentIndex ? 1 : 0.3)
                        }
                    }
                    .foregroundStyle(.white)
                }
            }
            
        case .failure(let error): fatalError("Unhandled case: \(error)")
            
        }
    }
    
    @ViewBuilder
    private var ForYouContent: some View {

        switch vm.forYouState {
        case .idle, .loading:
            ProgressView("Loading…")
                .foregroundStyle(.white)

        case .loaded(let movies):
            VStack(alignment: .leading, spacing: 12) {

                HStack {
                    Text("For You")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.textPrimary)

                    Spacer()

                    Button {

                    } label: {
                        Text("See more")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.textSecondary)
                    }
                }
                .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(movies) { movie in
                            MovieCard(
                                movie: movie,
                                cardWidth: 120,
                                cardHeight: 150
                            ).cornerRadius(16)
                            .onTapGesture {
                                vm.navigateToDetails(movie: movie)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }

        case .failure(let error): fatalError("Unhandled case: \(error)")
            
        }
    }

    
}
