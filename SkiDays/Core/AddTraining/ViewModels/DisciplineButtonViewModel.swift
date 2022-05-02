//
//  DisciplineButtonViewModel.swift
//  SkiDays
//
//  Created by MacOS on 30/04/2022.
//

import Foundation


enum DisciplineButtonViewModel: Int, CaseIterable{
    
    case SL
    case GS
    case SG
    case DH
    case FREE
    case PARA
 
    var title: String{
        switch self{
        case .SL: return "SL"
        case .GS: return "GS"
        case .SG: return "SG"
        case .DH: return "DH"
        case .FREE: return "PARA"
        case .PARA: return "PARA"
            
        }
    }
    
}
