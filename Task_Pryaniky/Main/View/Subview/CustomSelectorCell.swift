//
//  CustomSelectorCell.swift
//  Task_Pryaniky
//
//  Created by Анна Мельхова on 27.07.2020.
//  Copyright © 2020 Anna Melkhova. All rights reserved.
//

import UIKit
import SnapKit

protocol CustomSelectorCellDelegate: class {
    func getSelectorData(name: String) -> SelectorData?
    func selectorValueChanged(name: String, index: Int)
}

class CustomSelectorCell: UITableViewCell,  UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var delegate: CustomSelectorCellDelegate!
    var cellName: String!
    
    private var selector: UIPickerView = {
        return $0
    }(UIPickerView(frame: .zero))
    
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
        selector.delegate = self
        selector.dataSource = self
        contentView.addSubview(selector)
    }
    
    func setConstraints() {
        selector.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview().inset(16)
            maker.trailing.equalToSuperview().inset(16)
            maker.bottom.equalToSuperview()
        }
    }
    
    public func setName(_ name: String) {
        cellName = name
    }
    
    public func setSelector() {
        if let selectorData = delegate.getSelectorData(name: cellName) {
             selector.selectRow(selectorData.selectedId, inComponent: 0, animated: false)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let selectorData = delegate.getSelectorData(name: cellName) {
            return selectorData.variants.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let selectorData = delegate.getSelectorData(name: cellName) {
            let row = selectorData.variants[row].text
            return row
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate.selectorValueChanged(name: cellName, index: row)
    }
}


