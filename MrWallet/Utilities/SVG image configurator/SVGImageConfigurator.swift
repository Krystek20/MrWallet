import Foundation
import SDWebImageSVGCoder

protocol SVGImageConfiguring {
    func configure()
}

struct SVGImageConfigurator: SVGImageConfiguring {
    
    // MARK: - Properties
    
    private let imageCodersManager: SDImageCodersManager
    private let imageSVGCoder: SDImageSVGCoder
    
    // MARK: - Initialization
    
    init(imageCodersManager: SDImageCodersManager = .shared, imageSVGCoder: SDImageSVGCoder = .shared) {
        self.imageCodersManager = imageCodersManager
        self.imageSVGCoder = imageSVGCoder
    }
    
    // MARK: - Public
    
    func configure() {
        imageCodersManager.addCoder(imageSVGCoder)
    }
}
