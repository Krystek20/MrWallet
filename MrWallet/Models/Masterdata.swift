import Foundation

enum MasterdataType: String, Codable {
    case collection
}

struct Masterdata: Codable, Equatable {
    let type: MasterdataType
    let attributes: MasterdataAttributes
}
