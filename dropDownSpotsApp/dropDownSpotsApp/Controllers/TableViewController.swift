//
//  TableViewController.swift
//  dropDownSpotsApp
//
//  Created by wtildestar on 31/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

extension TableViewController: UIViewControllerPreviewingDelegate {
   
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let vc = ImageController()
        if let indexPath = tableView.indexPathForRow(at: location) {
            let section = sections[indexPath.section]
            let cellData = section.data[indexPath.row]
            vc.cellData = cellData
        }
        return vc
        
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
    
}

class TableViewController: UITableViewController {
    
    fileprivate var cellIdentifier = "cell"
    
    var sections: [SectionData] = [
        SectionData(
            open: true,
            data: [
                CellData(title: "Instagram", featureImage: UIImage(named: "2")!),
                CellData(title: "Instagram", featureImage: UIImage(named: "3")!)
            ]
        ),
        SectionData(
            open: true,
            data: [
                CellData(title: "Section", featureImage: UIImage(named: "1")!)
            ]
        ),
        SectionData(
            open: true,
            data: [
                CellData(title: "Twitter", featureImage: UIImage(named: "0")!),
                CellData(title: "YouTube", featureImage: UIImage(named: "1")!)
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 228/255, green: 230/255, blue: 234/255, alpha: 1)
        navigationItem.title = "spots"
        setupTableView()

        if traitCollection.forceTouchCapability ==  UIForceTouchCapability.available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
    }
    
    private func setupTableView() {
        tableView.register(CardCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }

    // MARK: - Cell data
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CardCell
        let section = sections[indexPath.section]
        let cellData = section.data[indexPath.row]
        cell.cellData = cellData
        cell.animate()
        return cell
    }
    
    // MARK: - Section & Rows
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sections[section].open {
            return 0
        }
        return sections[section].data.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    // MARK: - Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        button.tag = section
        button.setTitle("close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.openSection), for: .touchUpInside)
        return button
    }
    
    @objc fileprivate func openSection(button: UIButton) {
        print("button tag: ", button.tag)
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in sections[section].data.indices {
            let indexPathToDelete = IndexPath(row: row, section: section)
            indexPaths.append(indexPathToDelete)
        }
        
        // секция закрыта или открыта
        let isOpen = sections[section].open
        sections[section].open = !isOpen
        button.setTitle(isOpen ? "open" : "close", for: .normal)
        
        if isOpen {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
}

