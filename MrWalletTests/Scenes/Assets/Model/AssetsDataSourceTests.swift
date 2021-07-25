import XCTest
@testable import MrWallet

final class AssetsDataSourceTests: XCTestCase {

    private var sut: AssetsDataSource!
    private var tableView: UITableView!
    
    override func setUp() {
        tableView = UITableView()
        tableView.register(cell: AssetViewCell.self)
        
        sut = AssetsDataSource()
        sut.viewModels = [
            AssetViewCellModel.fixture,
            AssetViewCellModel.fixture
        ]
    }
    
    func testNumberOfRowInSectionReturnTwo() {
        // when
        let count = sut.tableView(tableView, numberOfRowsInSection: .zero)
        
        // then
        XCTAssertEqual(count, 2)
    }
    
    func testCellForRowAtReturnAssetViewCell() {
        // when
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: .zero, section: .zero))
        
        // then
        XCTAssertTrue(cell is AssetViewCell)
    }
    
    func testCellForRowAtSetViewModel() {
        // when
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: .zero, section: .zero)) as? AssetViewCell
        
        // then
        XCTAssertNotNil(cell?.viewModel)
    }
}
