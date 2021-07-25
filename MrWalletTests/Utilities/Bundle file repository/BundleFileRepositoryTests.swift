import XCTest
import Combine
@testable import MrWallet

final class BundleFileRepositoryTests: XCTestCase {

    private var sut: BundleFileRepository!
    private var bindings = Set<AnyCancellable>()
    
    override func setUp() {
        let bundle = Bundle(for: BundleFileRepositoryTests.self)
        sut = BundleFileRepository(bundle: bundle)
    }
    
    override func tearDown() {
        bindings.removeAll()
        sut = nil
    }
    
    func testDataForNameAndTypeReturnsData() throws {
        // given
        let expectation = XCTestExpectation()
        
        // when
        sut.data(for: "test", type: .json)
            .sink { completion in
                guard case .failure = completion else { return }
                XCTFail()
            } receiveValue: { data in
                // then
                XCTAssertEqual(data.count, 9)
                expectation.fulfill()
            }
            .store(in: &bindings)
    }

    func testDataForBadNameAndTypeReturnsError() throws {
        // given
        let expectation = XCTestExpectation()
        
        // when
        sut.data(for: "test1", type: .json)
            .sink { completion in
                // then
                guard case .failure(let error) = completion else { XCTFail(); return }
                XCTAssertEqual(error as? BundleFileRepositoryError, BundleFileRepositoryError.fileNotExist)
                expectation.fulfill()
            } receiveValue: { data in
                XCTFail()
            }
            .store(in: &bindings)
    }
}
