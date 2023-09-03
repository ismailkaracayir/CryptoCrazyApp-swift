//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by ismail karaçayır on 3.09.2023.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController  {

    
    @IBOutlet weak var tableView: UITableView!
    let cryptoVm = CryptoViewModel()
    let disposeBag = DisposeBag()
    var cryptoList : [Crypto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupBindings()
        cryptoVm.dowloandCurrencies()
    }
    
    private func setupBindings(){
        cryptoVm.error.observe(on: MainScheduler.asyncInstance).subscribe { errorString in
            
            print(errorString)
        }.disposed(by: disposeBag)
        
        cryptoVm.cryptos.observe(on: MainScheduler.asyncInstance).subscribe { cryptos in
            print(cryptos)
            self.cryptoList = cryptos
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
    }


}



extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
    
    
}

