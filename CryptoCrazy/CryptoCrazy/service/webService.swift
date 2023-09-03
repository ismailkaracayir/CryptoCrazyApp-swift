//
//  webService.swift
//  CryptoCrazy
//
//  Created by ismail karaçayır on 3.09.2023.
//

import Foundation
enum CryptoError : Error {
    case serverError
    case parsingError
}

class WebService {
    func dowloandCurrencies (url : URL ,completion : @escaping (Result<[Crypto],CryptoError>)->())  {
        URLSession.shared.dataTask(with: url) { data, response, err in
            
            if let _ = err{
                completion(.failure(.serverError))
            }else if let data = data{
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                }else{
                    completion(.failure(.parsingError))
                }
                
            }
            
        }.resume()
    }
    
}
