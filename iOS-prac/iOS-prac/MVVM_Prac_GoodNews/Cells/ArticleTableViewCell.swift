//
//  ArticleTableViewCell.swift
//  iOS-prac
//
//  Created by kong on 2021/10/02.
//

import SnapKit
import Then
import UIKit

class ArticleTableViewCell: UITableViewCell {

//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
    
    var titleLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .black
    }
    
    var descriptionLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .gray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
