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
                                    onFailure: ((MoyaError) -> Void)?) {
        switch result {
        case .success(let response):
            do {
                let model   = response.data
                let data    = try JSONDecoder().decode(T.self, from: model)
                onSuccess?(data)
            }
            catch let error {
                onFailure?(error as! MoyaError)
            }
        case .failure(let error):

            onFailure?(error)
        }
    }
}

extension MoyaError {
    var customErroMessage: String {
        switch self {
        case .imageMapping:
            return "Gagal Memuat Gambar"
        case .jsonMapping, .stringMapping, .objectMapping, .encodableMapping, .requestMapping, .parameterEncoding:
            return "Gagal Memuat Data"
        case .statusCode:
            return "Ada Kesalahan"
        case .underlying:
            return "Tida ada koneksi"
        }
    }

}
