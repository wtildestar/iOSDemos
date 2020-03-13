//
//  AddTaskViewController.swift
//  RxTodoApp
//
//  Created by wtildestar on 13/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBAction func save() {
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
            let title = self.taskTitleTextField.text else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true)
    }

}
