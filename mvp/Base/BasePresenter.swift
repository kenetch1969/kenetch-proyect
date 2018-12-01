//
//  BasePresenter.swift
//  mvp
//
//  Created by Juan Gerardo Cruz on 11/27/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

protocol BasePresenter {
    
    associatedtype View
    
    func attachView(view : View)
    
    func detachView()
    
    func destroy()
    
}
