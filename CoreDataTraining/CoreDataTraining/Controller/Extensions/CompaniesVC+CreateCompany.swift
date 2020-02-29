//
//  CompaniesVC+CreateCompany.swift
//  CoreDataTraining
//
//  Created by wtildestar on 29/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

extension CompaniesVC: CreateCompanyVCDelegate {
    
    func didEditCompany(company: Company) {
        let row = companies.firstIndex(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }

    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
