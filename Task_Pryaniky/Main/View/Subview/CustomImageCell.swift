//
//  CustomImageCell.swift
//  Task_Pryaniky
//
//  Created by Анна Мельхова on 27.07.2020.
//  Copyright © 2020 Anna Melkhova. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CustomImageCell: UITableViewCell {
    
    private var textInfoLabel: UILabel = {
        return $0
    }(UILabel(frame: .zero))
    
    private var loadedImageView: UIImageView = {
        return $0
    }(UIImageView(frame: .zero))
    
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
        contentView.addSubview(textInfoLabel)
        contentView.addSubview(loadedImageView)
    }
    
    func setConstraints() {
        loadedImageView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(16)
            maker.leading.equalToSuperview().inset(16)
            maker.width.equalTo(90)
            maker.height.equalTo(90)
        }
        textInfoLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(50)
            maker.leading.equalTo(loadedImageView.snp.trailing).offset(16)
            maker.trailing.equalToSuperview().inset(16)
        }
    }
    
    public func setText(_ text: String) {
        textInfoLabel.font = .boldSystemFont(ofSize: 20)
        textInfoLabel.text = text
    }
    
    public func setImage(_ url: URL) {
        self.loadedImageView.kf.setImage(with: url) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

