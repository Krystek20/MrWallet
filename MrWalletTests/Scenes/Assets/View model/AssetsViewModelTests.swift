import XCTest
import Combine
@testable import MrWallet

final class AssetsViewModelTests: XCTestCase {

    private var sut: AssetsViewModel!
    private var masterdataInteractor: MasterdataInteractorMock!
    private var bindings = Set<AnyCancellable>()
    private let factory = AssetViewCellModelFactory()
    
    override func setUp() {
        masterdataInteractor = MasterdataInteractorMock()
        sut = AssetsViewModel(
            interactor: masterdataInteractor
        )
    }
    
    override func tearDown() {
        masterdataInteractor = nil
        sut = nil
        bindings.removeAll()
    }
    
    func testViewDidLoadCallsIsLoadingAssetsWithFalseOnSetup() {
        // given
        let expectation = XCTestExpectation()

        sut.isLoadingAssets
            .sink(receiveValue: { isLoading in
                // then
                XCTAssertFalse(isLoading)
                expectation.fulfill()
            })
            .store(in: &bindings)
        
        // when
        sut.viewDidLoad.send()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testViewDidLoadCallsIsLoadingAssetsWithTrueWhenLoading() {
        verifyIsLoading(expected: true, loadableState: .loading)
    }
    
    func testViewDidLoadCallsIsLoadingAssetsWithFalseWhenLoaded() {
        verifyIsLoading(expected: false, loadableState: .loaded(.fixture))
    }
    
    func testViewDidLoadCallsIsLoadingAssetsWithFalseWhenError() {
        verifyIsLoading(expected: false, loadableState: .failed(ErrorStub.someError))
    }
    
    private func verifyIsLoading(expected: Bool, loadableState: LoadingState<MasterdataAttributes>) {
        // given
        let expectation = XCTestExpectation()
        sut.viewDidLoad.send()
        
        sut.isLoadingAssets
            .dropFirst()
            .sink(receiveValue: { isLoading in
                // then
                expected
                    ? XCTAssertTrue(isLoading)
                    : XCTAssertFalse(isLoading)
                expectation.fulfill()
            })
            .store(in: &bindings)

        // when
        masterdataInteractor.loadableSubjectSet?.value = loadableState
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testViewDidLoadCallsAssetViewModelsWithThreeItems() {
        // given
        let expectation = XCTestExpectation()
        let expected = [
            factory.createViewModel(from: .fixtureCryptocoin),
            factory.createViewModel(from: .fixtureCommodity),
            factory.createViewModel(from: .fixtureFiat())
        ]
        sut.viewDidLoad.send()
        
        sut.assetViewModels
            .dropFirst()
            .sink(receiveValue: { viewModels in
                // then
                XCTAssertEqual(viewModels, expected)
                expectation.fulfill()
            })
            .store(in: &bindings)
        
        // when
        masterdataInteractor.loadableSubjectSet?.value = .loaded(.fixture)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSegmentChangedCallsAssetViewModelsWithOneItemWhenFilterCryptocoin() {
        verifySegmentChanged(.cryptocoins, expected: [
            factory.createViewModel(from: .fixtureCryptocoin)
        ])
    }
    
    func testSegmentChangedCallsAssetViewModelsWithOneItemWhenFilterCommodity() {
        verifySegmentChanged(.commodities, expected: [
            factory.createViewModel(from: .fixtureCommodity)
        ])
    }
    
    func testSegmentChangedCallsAssetViewModelsWithOneItemWhenFilterFiat() {
        verifySegmentChanged(.fiats, expected: [
            factory.createViewModel(from: .fixtureFiat())
        ])
    }
    
    private func verifySegmentChanged(_ filter: AssetFilters, expected: [AssetViewCellModel?]) {
        // given
        let expectation = XCTestExpectation()
        sut.viewDidLoad.send()
        masterdataInteractor.loadableSubjectSet?.value = .loaded(.fixture)
        
        sut.assetViewModels
            .dropFirst()
            .sink(receiveValue: { viewModels in
                // then
                XCTAssertEqual(viewModels, expected)
                expectation.fulfill()
            })
            .store(in: &bindings)
        
        // when
        sut.segmentChanged.send(filter.rawValue)
        wait(for: [expectation], timeout: 1.0)
    }
}
