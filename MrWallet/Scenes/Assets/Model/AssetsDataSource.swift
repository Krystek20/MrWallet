import UIKit.UITableView

final class AssetsDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var viewModels: [AssetViewCellModelType] = []
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AssetViewCell.self, for: indexPath)
        guard let assetCell = cell as? AssetViewCell,
              let viewModel = viewModels[safe: indexPath.row] else { return cell }
        assetCell.viewModel = viewModel
        return assetCell
    }
}
