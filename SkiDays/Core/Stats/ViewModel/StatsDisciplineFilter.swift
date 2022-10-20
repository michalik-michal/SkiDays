import Foundation

// swiftlint:disable: identifier_name

enum StatsDisciplineFilter: Int, CaseIterable {
    case sl
    case gs
    case sg
    case dh
    case para
    case free

    var title: String {
        switch self {
        case .sl: return "SL"
        case .gs: return "GS"
        case .sg: return "SG"
        case .dh: return "DH"
        case .para: return "PARA"
        case .free: return "FREE"
        }
    }
}
