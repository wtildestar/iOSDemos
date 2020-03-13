//
//  TaskListViewController.swift
//  RxTodoApp
//
//  Created by wtildestar on 13/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let disposeBag            = DisposeBag()
    private var tasks         = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,
            let addTaskVC = nav.viewControllers.first as? AddTaskViewController else {
                fatalError("Controller not found...")
        }
        
        addTaskVC.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                self.filterTasks(by: priority)
            }).disposed(by: disposeBag)
    }
    
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl) {
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
                print(tasks)
                }).disposed(by: disposeBag)
        }
    }

}
