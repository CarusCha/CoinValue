//
//  ExchangeViewController.swift
//  CoinValue
//
//  Created by carus on 28/4/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ExchangeViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var assetLabel: UILabel!
        
    private var viewModel: ExchangeViewModel = ExchangeViewModel(asset: "CRO")
    let disposeBag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        // bind asset id to navigation title
        viewModel.asset
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { asset in
                self.title = asset
            })
            .disposed(by: disposeBag)
        
        // bind amountTextField text to amount relay
        amountTextField.rx.text.orEmpty
            .map({Double($0) ?? 0.0})
            .bind(to: viewModel.amount)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        // bind priceStr to priceLabel in view
        viewModel.priceStr
            .observe(on: MainScheduler.instance)
            .bind(to: priceLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
