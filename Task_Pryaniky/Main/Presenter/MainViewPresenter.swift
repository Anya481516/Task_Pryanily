//
//  MainViewPresenter.swift
//  Task_Pryaniky
//
//  Created by Анна Мельхова on 27.07.2020.
//  Copyright © 2020 Anna Melkhova. All rights reserved.
//

import Foundation

class MainViewPresenter: CustomSelectorCellDelegate {
    
    weak private var mainView : MainViewInputProtocol?
    public var list = [String]()
    public var data = [DataItem]()
    let service = MainService()
    
    func setView(mainView : MainViewInputProtocol?) {
        self.mainView = mainView
    }
    
    func viewLoaded() {
        fetchData()
    }
    
    func fetchData() {
        service.fetchData { (result) in
            switch result {
            case .success(let allData):
                self.list = allData.view
                self.data = allData.data
                self.mainView?.reloadData()
            case .failure(_):
                break
            }
        }
    }
    
    public func dataValueByName(name: String) -> DataValue? {
        for dataItem in data {
            if dataItem.name == name {
                return dataItem.data
            }
        }
        return nil
    }
    
    func rowSelected(rowIndex: Int) {
        let name = list[rowIndex]
        mainView?.showPressedAlert(name: name)
    }
    
    func selectorValueChanged(name: String, index: Int) {
        let selectorData = dataValueByName(name: name)
        var selectedItemName = ""
        switch selectorData {
        case .selectorData(let value):
            selectedItemName = value.variants[index].text
        default:
            selectedItemName = ""
        }
        mainView?.showSelectorAlert(name: name, selected: selectedItemName)
    }
    
    public func getSelectorData(name: String) -> SelectorData? {
        let selectorData = dataValueByName(name: name)
        
        switch selectorData {
        case .selectorData(let value):
            return value
        default:
            return nil
        }
    }
    
    public func getCellHeight(name: String) -> Int {
        let dataItem = dataValueByName(name: name)
        switch dataItem {
        case .selectorData(_):
            return 180
        case .imageData(_):
            return 120
        case .textData(_):
            return 60
        default:
            return 0
        }
    }
}
