//
//  MainPresenterTest.swift
//  MVPTests
//
//  Created by wtildestar on 04/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import XCTest
@testable import MVP

class MockView: MainViewProtocol {
    var titleTest: String?
    func setGreeting(greeting: String) {
        self.titleTest = greeting
    }
}

class MainPresenterTest: XCTestCase {

    var view: MockView!
    var person: Person!
    var presenter: MainPresenter!
    
    override func setUp() {
        view = MockView()
        person = Person(firstName: "Bar", lastName: "Baz")
        presenter = MainPresenter(view: view, person: person)
    }

    override func tearDown() {
        view = nil
        person = nil
        presenter = nil
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(person, "person is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
    }

    func testView() {
        presenter.showGreeting()
        XCTAssertEqual(view.titleTest, "Bar Baz")
    }
    
    func testPersonModel() {
        XCTAssertEqual(person.firstName, "Bar")
        XCTAssertEqual(person.lastName, "Baz")
    }
}
