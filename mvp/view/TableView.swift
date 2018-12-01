//
//  TableView.swift
//  mvp
//
//  Created by Juan Gerardo Cruz on 11/27/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

protocol TableView: NSObjectProtocol{
    func startLoading()
    func stopLoading()
    func showData(list : [Country])
    func  showMessage ( mensaje : String )
}
