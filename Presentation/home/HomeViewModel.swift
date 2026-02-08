import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var query:String = ""
    @Published private(set) var state: ViewState<[Movie]> = .idle
    
    @Published private(set) var forYouState: ViewState<[Movie]> = .idle
    
    private let searchUseCase: GetAllMoviesUseCase
    private var searchTask: Task<Void, Never>?
    
    private let router: AppRouter

    init(searchUseCase: GetAllMoviesUseCase, appRouter: AppRouter) {
        self.searchUseCase = searchUseCase
        self.router = appRouter
        onQueryChanged("Will Smith")
        
        Task {
            await self.fetchForYouContent()
        }
    }
    
    func navigateToDetails(movie: Movie) {
        router.navigate(to: .DetailsScreen(id: movie.id))
    }

    
    func onQueryChanged(_ query: String) {
        self.query = query
        print("[SearchViewModel] onQueryChanged -> query='\(query)' ")
        
        searchTask?.cancel()
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else {
            self.state = .idle
            return
        }
        
        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 400_000_000)
            guard let self else { return }
            guard !Task.isCancelled else { return }
            await self.search(page: 1)
        }
    }
    
    func search(page: Int) async {
        guard Task.isCancelled == false else { return }
        state = .loading
        
        do {
            let movies = try await searchUseCase.execute(query: query, page: page)
            state = .loaded(movies)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
    
    
    func fetchForYouContent() async {
        guard Task.isCancelled == false else { return }
        forYouState = .loading
        
        do {
            let movies = try await searchUseCase.execute(query: "Will", page: 1)
            forYouState = .loaded(movies)
        } catch {
            forYouState = .failure(error.localizedDescription)
        }
    }

}
