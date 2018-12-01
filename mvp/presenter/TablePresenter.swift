//
//  tablePresenter.swift
//  mvp
//
//  Created by Juan Gerardo Cruz on 11/27/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

class TablePresenter: BasePresenter {
    
    private let serviceCountry:Services
    typealias View = TableView
    private var tableView : TableView?
    
    init(serviceCountry: Services) {
        self.serviceCountry = serviceCountry
    }
    
    func attachView(view: TableView) {
        self.tableView = view
    }
    
    func detachView() {
        self.tableView = nil
    }
    
    func destroy() {
    }
    
    func getContriesList(){
        tableView?.startLoading()
        serviceCountry.getCountry(with: "Country") { [weak self] list in
            self?.tableView?.stopLoading()
            self?.tableView?.showData(list: list)
        }
    }
    
    func getContriesList(with country: String){
        tableView?.startLoading()
        serviceCountry.getCountryUrl(name: country) { list, error in
            self.tableView?.stopLoading()
            if error == nil {
              self.tableView?.showData(list: list!)
            }else{
              self.tableView?.showMessage(mensaje: (error?.localizedDescription)!)
            }
        }
    }
}
