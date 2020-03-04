//
//  DetailPresenter.swift
//  MVP
//
//  Created by wtildestar on 04/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class {
    func setComment(comment: Comment?)
}

protocol DetailViewPresenterProtocol {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?)
    func setComment()
    func tap()
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router:  RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var comment: Comment?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.comment = comment
    }
    
    func tap() {
        router?.popRoot()
    }
    
    func setComment() {
        self.view?.setComment(comment: comment)
    }
    
}
