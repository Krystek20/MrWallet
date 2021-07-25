import XCTest
import Combine
@testable import MrWallet

final class MasterdataRepositoryTests: XCTestCase {
    
    private var sut: MasterdataRepository!
    private var bundleFileRepository: BundleFileRepositoryMock!
    private var bindings = Set<AnyCancellable>()
    
    private func setupSutWith(data: Data) {
        bundleFileRepository = BundleFileRepositoryMock(expectedData: data)
        sut = MasterdataRepository(bundleFileRepository: bundleFileRepository)
    }
    
    override func tearDown() {
        bundleFileRepository = nil
        sut = nil
        bindings.removeAll()
    }
    
    func testLoadMasterdataInfoWithSuccess() throws {
        // given
        let data = try JSONEncoder().encode(MasterdataInfo.fixture)
        setupSutWith(data: data)
        let expectation = XCTestExpectation()
        
        // when
        sut.load()
            .sink(receiveCompletion: { completion in
                guard case .failure = completion else { return }
                XCTFail()
            }, receiveValue: { masterdataInfo in
                // then
                XCTAssertEqual(masterdataInfo, MasterdataInfo.fixture)
                expectation.fulfill()
            })
            .store(in: &bindings)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadMasterdataInfoWithFail() {
        // given
        setupSutWith(data: Data())
        let expectation = XCTestExpectation()
        
        // when
        sut.load()
            .sink(receiveCompletion: { completion in
                guard case .failure = completion else { XCTFail(); return }
                // then
                expectation.fulfill()
            }, receiveValue: { masterdataInfo in
                XCTFail()
            })
            .store(in: &bindings)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
