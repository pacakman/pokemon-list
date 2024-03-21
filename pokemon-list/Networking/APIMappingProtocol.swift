//
//  APIMappingProtocol.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import Foundation
import Moya

protocol APIMappingProtocol {
    
}

extension APIMappingProtocol {
    func handleResult<T: Decodable>(_ result: Result<Moya.Response, MoyaError>,
                                      typeResponse: T.Type,
                                      onSuccess: ((T) -> Void)?,
                                      onFailure: ((Error) -> Void)?) {
        switch result {
        case .success(let response):
            do {
                let model   = response.data
                let data    = try JSONDecoder().decode(T.self, from: model)
                onSuccess?(data)
            }
            catch let error {
                onFailure?(error)
            }
        case .failure(let error):
            onFailure?(error)
        }
    }
}
