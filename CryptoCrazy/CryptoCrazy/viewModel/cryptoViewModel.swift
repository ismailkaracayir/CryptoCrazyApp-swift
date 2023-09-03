//
//  cryptoViewModel.swift
//  CryptoCrazy
//
//  Created by ismail karaçayır on 3.09.2023.
//

import Foundation
import RxCocoa
import RxSwift

class CryptoViewModel {
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let isLoading : PublishSubject<Bool> = PublishSubject()
    
    func dowloandCurrencies (){
        self.isLoading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().dowloandCurrencies(url: url) { result in
            self.isLoading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                switch error {
                case .serverError:
                    self.error.onNext("Server error")
                case .parsingError:
                    self.error.onNext("Parsing error")
                    
                }
                
                
            }
            
        }

    }
    
}
