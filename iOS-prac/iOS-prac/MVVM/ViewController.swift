//
//  ViewController.swift
//  iOS-prac
//
//  Created by kong on 2021/09/27.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet var datetimeLabel: UILabel!

    @IBAction func onYesterday() {
        viewModel.moveDay(day: -1)
    }

    @IBAction func onNow() {
        datetimeLabel.text = "Loading.."
        
        viewModel.reload()
    }

    @IBAction func onTomorrow() {
        viewModel.moveDay(day: 1)
    }

    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.dateTimeString
            .bind(to: datetimeLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.reload()
    }
}
