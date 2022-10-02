import Foundation

enum StatsDisciplineFilter: Int, CaseIterable {
    case all
    case sl
    case gs
    case sg
    case dh
    case free
    case para
    
    var title: String {
        switch self {
        case .all: return "ALL"
        case .sl: return "SL"
        case .gs: return "GS"
        case .sg: return "SG"
        case .dh: return "DH"
        case .free: return "FREE"
        case .para: return "PARA"
        }
    }
}
