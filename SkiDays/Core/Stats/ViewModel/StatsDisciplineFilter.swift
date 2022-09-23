import Foundation

enum StatsDisciplineFilter: Int, CaseIterable {
    case sl
    case gs
    case sg
    case dh
    case free
    case para
    
    var title: String {
        switch self {
        case .sl: return "SL"
        case .gs: return "GS"
        case .sg: return "SG"
        case .dh: return "DH"
        case .free: return "FREE"
        case .para: return "PARA"
        }
    }
}
