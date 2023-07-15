import Foundation

struct MoviesViewModel {
    let id: String
    let title: String
    let year: String
    let type: String
    let imageURLString: String
    
    var posterData: Data?
    
    var duration: String?
    var rating: String?
    
    var details: MovieDetail?
    
    init(with search: MovieSearch) {
        self.id = search.imdbID
        self.title = search.title
        self.year = search.year
        self.type = search.type.rawValue
        self.imageURLString = search.poster
    }
}
