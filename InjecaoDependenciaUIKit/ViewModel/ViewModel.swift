//
//  ViewModel.swift
//  InjecaoDependenciaSwiftUI
//
//  Created by Gabriel Vicentin Negro on 07/11/24.
//

import Foundation

class ViewModel: ViewModelProtocol {
    
    func getData(_ completion: @escaping (String) -> Void) {
        // Funçao que realmente vai na internet e recebe dados de alguma API por exemplo.
        //print("DataRecivied!")
        completion("Cool data!")
    }
    
}
