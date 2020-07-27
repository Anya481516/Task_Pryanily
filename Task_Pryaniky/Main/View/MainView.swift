//
//  MainView.swift
//  Task_Pryaniky
//
//  Created by Анна Мельхова on 27.07.2020.
//  Copyright © 2020 Anna Melkhova. All rights reserved.
//

import UIKit

protocol MainViewInputProtocol: class {
    func reloadData()
    func openNewView(view: UIViewController)
    func showPressedAlert(name: String)
    func showSelectorAlert(name: String, selected: String)
}

class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource, MainViewInputProtocol {
    
    // MARK:- PROPERTIES
    private var myTableView: UITableView!
    private let mainViewPresenter = MainViewPresenter()
    
    // MARK:- METHODS:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mainViewPresenter.setView(mainView: self)
        mainViewPresenter.viewLoaded()
    }
    
    func reloadData() {
        myTableView.reloadData()
    }
    
    func setupView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        self.myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        self.myTableView.register(CustomImageCell.self, forCellReuseIdentifier: CustomImageCell.reuseIdentifier)
        self.myTableView.register(CustomTextCell.self, forCellReuseIdentifier: CustomImageCell.reuseIdentifier)
        self.myTableView.register(CustomSelectorCell.self, forCellReuseIdentifier: CustomImageCell.reuseIdentifier)
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 120
        self.view.addSubview(self.myTableView)
    }
    
    func showPressedAlert(name: String) {
        let alert = UIAlertController(title: "Вы нажали на объект:", message: name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSelectorAlert(name: String, selected: String) {
        let alert = UIAlertController(title: "Вы поменяли значение на объекте: \(name)", message: "на значение: \(selected)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainViewPresenter.rowSelected(rowIndex: indexPath.row)
    }
    
    func openNewView(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewPresenter.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = mainViewPresenter.list[indexPath.row]
        let data = mainViewPresenter.dataValueByName(name: name)
        
        switch data {
        case .imageData(let value):
            let cell = CustomImageCell()
            cell.setText(value.text)
            cell.setImage(value.url)
            return cell
        case .textData(let value):
            let cell = CustomTextCell()
            cell.setText(value.text)
            return cell
        case .selectorData(_):
            let cell = CustomSelectorCell()
            cell.delegate = mainViewPresenter
            cell.setName(name)
            cell.setSelector()
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let name = mainViewPresenter.list[indexPath.row]
        return CGFloat(mainViewPresenter.getCellHeight(name: name))
    }
}
