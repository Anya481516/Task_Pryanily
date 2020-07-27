//
//  CustomTextCell.swift
//  Task_Pryaniky
//
//  Created by Анна Мельхова on 27.07.2020.
//  Copyright © 2020 Anna Melkhova. All rights reserved.
//

import UIKit
import SnapKit

class CustomTextCell: UITableViewCell {
    
    private var textInfoLabel: UILabel = {
        return $0
    }(UILabel(frame: .zero))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // required implementation
    }
    
    func addSubviews() {
        textInfoLabel.textAlignment = .center
        contentView.addSubview(textInfoLabel)
    }
    
    func setConstraints() {
        textInfoLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(16)
            maker.leading.equalToSuperview().inset(16)
            maker.trailing.equalToSuperview().inset(16)
        }
    }
    
    public func setText(_ text: String) {
        textInfoLabel.font = .boldSystemFont(ofSize: 20)
        textInfoLabel.text = text
    }
}
