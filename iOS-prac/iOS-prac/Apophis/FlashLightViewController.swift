//
//  FlashLightViewController.swift
//  iOS-prac
//
//  Created by kong on 2021/07/21.
//

import Then
import SnapKit
import UIKit
import MSCircularSlider

class FlashLightViewController: UIViewController {
    
    // MARK: - UIComponenets
    var openButton = UIButton().then {
        $0.backgroundColor = .red
        $0.addTarget(self, action: #selector(touchDownOpenButton(_:)), for: .touchDown)
        $0.addTarget(self, action: #selector(touchUpOpenButton(_:)), for: .touchUpInside)
    }
    
    var sliderView = UIView().then {
        $0.backgroundColor = .green
    }
    
    // MARK: - Properties
    
    var timer = Timer()
    var progressTimer = Timer()
    var startTimer = false
    var circular = MSCircularSlider()
    
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
        view.addSubview(circular)
        circular.handleColor = .clear
        circular.handleType = .smallCircle
        circular.lineWidth = 3
        circular.minimumValue = 0
        circular.maximumValue = 5
    }
    
    func setConstraints() {
        openButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        circular.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(54)
        }
        
    }
    
    // 타이머가 시작된다면 5초 뒤에 timeLimit()을 실행한다
    func timeLimitStart() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(FlashLightViewController.timeLimit), userInfo: nil, repeats: false)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(FlashLightViewController.fillProgress), userInfo: nil, repeats: true)
    }
    
    
    @objc func timeLimit() {
        print("5s timeLimit, 열려라 뚜껑")
        openButton.backgroundColor = .blue
        circular.currentValue = 5
    }
    
    @objc func fillProgress() {
        circular.currentValue += 0.05
    }
    
    // 타이머를 리셋시켜주는 함수
    func timeLimitStop() {
        startTimer = false
        timer.invalidate()
        progressTimer.invalidate()
        circular.currentValue = 0
    }
    
}


// MARK: - Protocols

// MARK: - Extension
