//
//  Day3FlashLightViewController.swift
//  iOS-prac
//
//  Created by kong on 2021/07/23.
//

import Then
import SnapKit
import UIKit

class Day3FlashLightViewController: UIViewController {
    
    // MARK: - UIComponenets
    
    var background = UIImageView().then {
        $0.image = UIImage(named: "flashLight")
        $0.contentMode = .scaleAspectFill
    }

    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        view.addSubview(background)
    }
    
    func setConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}


// MARK: - Protocols

// MARK: - Extension
