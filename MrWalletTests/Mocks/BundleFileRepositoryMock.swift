import Foundation
import Combine
@testable import MrWallet

final class BundleFileRepositoryMock: BundleFileRepositoring {
    
    // MARK: - Properties
    
    private(set) var nameSet: String?
    private(set) var typeSet: String?
    private(set) var dataCounter: Int = .zero
    private let expectedData: Data
    
    // MARK: - Initialization
    
    init(expectedData: Data) {
        self.expectedData = expectedData
    }
    
    func data(for name: String, type: String) -> AnyPublisher<Data, Error> {
        nameSet = name
        typeSet = type
        dataCounter += 1
        return Just(expectedData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
