//
//  VIewModelMock.swift
//  InjecaoDependenciaSwiftUI
//
//  Created by Gabriel Vicentin Negro on 07/11/24.
//

import Foundation

class ViewModelMock: ViewModelProtocol {
    func getData(_ completion: @escaping (String) -> Void) {
       //Aqui eu posso retornar qualquer dado fake que eu quiser para testar mutiplas situações diferentes de resultado.
        completion("Fake data!")
    }
    
}
