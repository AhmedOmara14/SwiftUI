import SwiftUI
import AVKit

struct DetailsScreen: View {
    private let moviewID: Int
    @StateObject private var vm: DetailsViewModel

    init(moviewID: Int, viewModel: DetailsViewModel) {
        self.moviewID = moviewID
        _vm = StateObject(wrappedValue: viewModel)
    }

    static func create(router: AppRouter, moviewID: Int) -> DetailsScreen {
        let dataSource = MovieRemoteDataSourceImpl(
            token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmVjOGFiOTM0ZmQxMmFhMTlkOTU2Mjc3MGJlYTEzMyIsIm5iZiI6MTc2ODY1Mjc0NC41ODQsInN1YiI6IjY5NmI3ZmM4YzNjOTEzYjU4NzIwYzZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ggy9tOH_VSmqt2Y1J7LN8_4_YlSCiLUCE7zPt2j7rvY"
        )
        let repo = MovieRepositoryImpl(remoteDataSource: dataSource)
        let useCase = DefaultGetMovieDetailsUseCase(repository: repo)
        let viewModel = DetailsViewModel(movieDetialsUseCase: useCase, appRouter: router)
        return DetailsScreen(moviewID: moviewID, viewModel: viewModel)
    }

    var body: some View {
        ZStack {
            background

            DetailsContent
                .ignoresSafeArea(edges: .top)

            topBar
        }
        .navigationBarHidden(true)
        .task {
            await vm.fetchMovieDetials(movieId: "\(moviewID)")
        }
    }
}

private extension DetailsScreen {

    var background: some View {
        LinearGradient(
            colors: [
                Color(red: 0.20, green: 0.13, blue: 0.42),
                Color.black
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    var topBar: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: { vm.onBackPressure() }) {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        )
                }
                .padding(.leading, 20)

                Spacer()

                Button(action: {}) {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(90))
                        )
                }
                .padding(.trailing, 20)
            }

            Spacer()
        }
        .padding(.top, 8)
    }
}

private extension DetailsScreen {

    var DetailsContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                headerSection
                detailsSection
            }
        }
    }

    var headerSection: some View {
        Group {
            switch vm.state {
            case .loaded(let movie):
                poster(movie: movie)
            case .idle, .loading, .failure:
                posterPlaceholder
            }
        }
        .frame(height: 340)
    }

    var detailsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            switch vm.state {
            case .idle, .loading:
                detailsPlaceholder

            case .loaded(let movie):
                loadedDetails(movie)

            case .failure(let message):
                Text(message)
                    .foregroundStyle(.white)
                    .padding(.top, 12)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 28)
    }
}

private extension DetailsScreen {

    func poster(movie: MovieDetails) -> some View {
        ZStack {
            let posterPath = movie.posterPath ?? ""
            let fullURL = posterPath.isEmpty ? "" : "https://image.tmdb.org/t/p/w500\(posterPath)"
            
            AsyncImage(url: URL(string: fullURL)) { phase in
                switch phase {
                case .empty:
                    posterPlaceholder
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 340)
                        .clipped()
                        .clipShape(CenterCurvedBottomShape())
                case .failure(let error):
                    posterPlaceholder
                        .overlay(
                            VStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white.opacity(0.3))
                                Text("Image failed to load")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        )
                @unknown default:
                    posterPlaceholder
                }
            }

            playButton
                .padding(.top, 75)
                .offset(y: 340 / 2 - 40)
        }
    }
    var posterPlaceholder: some View {
        Rectangle()
            .fill(Color.white.opacity(0.08))
            .frame(maxWidth: .infinity)
            .frame(height: 340)
            .clipped()
            .clipShape(CenterCurvedBottomShape())
            .overlay(
                ProgressView()
                    .foregroundStyle(.white)
            )
    }

    var playButton: some View {
        Circle()
            .fill(Color(red: 0.55, green: 0.36, blue: 0.55).opacity(0.6))
            .frame(width: 60, height: 60)
            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
            .overlay(
                Image(systemName: "play.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            )
    }
}

private extension DetailsScreen {

    func loadedDetails(_ movie: MovieDetails) -> some View {
        let movieYear: String = {
            if let date = movie.releaseDate, date.count >= 4 { return String(date.prefix(4)) }
            return "—"
        }()

        return VStack(alignment: .leading, spacing: 12) {
            Text(movieYear)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.textSecondary)

            Text(movie.title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.center)

            HStack(spacing: 12) {
                Pill(text: "Fantasy")
                Pill(text: "2h 7min")
                Pill(
                    text: String(format: "%.1f", 2),
                    icon: "star.fill",
                    isRating: true
                )
            }

            Divider()
                .background(Color.gray.opacity(0.3))
                .padding(.vertical, 8)

            Text("Synopsis")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.textPrimary)

            Text(movie.overview ?? "—")
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
                .fixedSize(horizontal: false, vertical: true)

            if !movie.productionCompanies.isEmpty {
                Text("Production Companies")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(movie.productionCompanies, id: \.id) { company in
                            Pill(text: company.name)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension DetailsScreen {

    var detailsPlaceholder: some View {
        VStack(alignment: .leading, spacing: 12) {
            roundedPlaceholder(width: 60, height: 14)
            roundedPlaceholder(width: nil, height: 22)
            roundedPlaceholder(width: 220, height: 18)

            Divider()
                .background(Color.gray.opacity(0.3))
                .padding(.vertical, 8)

            roundedPlaceholder(width: 100, height: 18)

            VStack(spacing: 8) {
                ForEach(0..<4, id: \.self) { _ in
                    roundedPlaceholder(width: nil, height: 14)
                }
            }
        }
    }

    func roundedPlaceholder(width: CGFloat?, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white.opacity(0.08))
            .frame(width: width, height: height)
    }
}
