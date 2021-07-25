import Foundation
import Combine

protocol BundleFileRepositoring {
    func data(for name: String, type: String) -> AnyPublisher<Data, Error>
}

enum BundleFileRepositoryError: Error, Equatable {
    case fileNotExist
    case badDataFormat
}

final class BundleFileRepository: BundleFileRepositoring {
    
    // MARK: - Properties
    
    private let bundle: Bundle
    
    // MARK: - Initialization
    
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    // MARK: - Public
    
    func data(for name: String, type: String = .json) -> AnyPublisher<Data, Error> {
        Just(bundle.path(forResource: name, ofType: type))
            .tryMap {
                guard let path = $0 else { throw BundleFileRepositoryError.fileNotExist }
                return try Data(contentsOf: URL(fileURLWithPath: path))
            }
            .eraseToAnyPublisher()
    }
}
