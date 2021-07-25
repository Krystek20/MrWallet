import Foundation
import Combine

protocol Repository {
    func load() -> AnyPublisher<MasterdataInfo, Error>
}

struct MasterdataRepository: Repository {

    // MARK: - Properties
    
    private let masterdataFileName = "Mastrerdata"
    private let bundleFileRepository: BundleFileRepositoring
    private let decoder: JSONDecoder
    
    // MARK: - Initialization
    
    init(bundleFileRepository: BundleFileRepositoring = BundleFileRepository(),
         decoder: JSONDecoder = JSONDecoder(keyDecodingStrategy: .convertFromSnakeCase)) {
        self.decoder = decoder
        self.bundleFileRepository = bundleFileRepository
    }
    
    // MARK: - Public
    
    func load() -> AnyPublisher<MasterdataInfo, Error> {
        bundleFileRepository.data(for: masterdataFileName, type: .json)
            .decode(type: MasterdataInfo.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
