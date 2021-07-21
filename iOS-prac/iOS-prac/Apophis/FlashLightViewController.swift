//
//  FlashLightViewController.swift
//  iOS-prac
//
//  Created by kong on 2021/07/21.
//

import Then
import SnapKit
import UIKit

class FlashLightViewController: UIViewController {
    
    // MARK: - UIComponenets
    var openButton = UIButton().then {
        $0.backgroundColor = .red
        $0.addTarget(self, action: #selector(touchDownOpenButton(_:)), for: .touchDown)
        $0.addTarget(self, action: #selector(touchUpOpenButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    var timer = Timer()
    var startTimer = false
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
    }
    
    // MARK: - Actions
    
    @objc func touchDownOpenButton(_ sender: UIButton) {
        print("touchDownOpenButton")
        timeLimitStart()
    }
    
    @objc func touchUpOpenButton(_ sender: UIButton) {
        print("touchUpOpenButton")
        timeLimitStop()
    }
    
    
    
    // MARK: - Methods
    
    func setView() {
        view.addSubview(openButton)
    }
    
    func setConstraints() {
        openButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
    
    // 타이머가 시작된다면 5초 뒤에 timeLimit()을 실행한다
    func timeLimitStart() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(FlashLightViewController.timeLimit), userInfo: nil, repeats: false)
    }
    
    @objc func timeLimit() {
        print("5s timeLimit, 열려라 뚜껑")
        openButton.backgroundColor = .blue
    }
    
    // 타이머를 리셋시켜주는 함수
    func timeLimitStop() {
        startTimer = false
        timer.invalidate()
    }
    
}


// MARK: - Protocols

// MARK: - Extension
