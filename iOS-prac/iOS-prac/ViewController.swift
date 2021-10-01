//
//  ViewController.swift
//  iOS-prac
//
//  Created by kong on 2021/07/01.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var dateTimeLabel = UILabel()
    var yesterdayButton = UIButton().then {
        $0.setTitle("yesterday", for: .normal)
        $0.backgroundColor = .blue
        $0.addTarget(self, action: #selector(onYesterday), for: .touchUpInside)
    }
    var nowButton = UIButton().then {
        $0.setTitle("now", for: .normal)
        $0.backgroundColor = .blue
        $0.addTarget(self, action: #selector(onNow), for: .touchUpInside)
    }
    var tomorrowButton = UIButton().then {
        $0.setTitle("tomorrow", for: .normal)
        $0.backgroundColor = .blue
        $0.addTarget(self, action: #selector(onTomorrow), for: .touchUpInside)
    }
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        viewModel.dateTimeString
            .bind(to: dateTimeLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.reload()
    }
    
    func setView() {
        view.backgroundColor = .white
        view.addSubview(dateTimeLabel)
        view.addSubview(yesterdayButton)
        view.addSubview(nowButton)
        view.addSubview(tomorrowButton)
        
        dateTimeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        nowButton.snp.makeConstraints {
            $0.top.equalTo(dateTimeLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        yesterdayButton.snp.makeConstraints {
            $0.top.equalTo(dateTimeLabel.snp.bottom).offset(10)
            $0.trailing.equalTo(nowButton.snp.leading).offset(-10)
        }
        
        tomorrowButton.snp.makeConstraints {
            $0.top.equalTo(dateTimeLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nowButton.snp.trailing).offset(10)
        }
    }
    
    @objc
    func onYesterday() {
        viewModel.moveDay(day: -1)
    }
    
    @objc
    func onNow() {
        dateTimeLabel.text = "Loading.."
        viewModel.reload()
    }
    
    @objc
    func onTomorrow() {
        viewModel.moveDay(day: 1)
    }
    
}
