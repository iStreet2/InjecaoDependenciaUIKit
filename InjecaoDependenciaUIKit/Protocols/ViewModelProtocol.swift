//
//  ViewModelProtocol.swift
//  InjecaoDependenciaSwiftUI
//
//  Created by Gabriel Vicentin Negro on 07/11/24.
//

import Foundation

protocol ViewModelProtocol {
    func getData(_ completion: @escaping (String) -> Void)
}
