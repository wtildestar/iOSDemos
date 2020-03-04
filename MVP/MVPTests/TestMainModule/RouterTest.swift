//
//  RouterTest.swift
//  MVPTests
//
//  Created by wtildestar on 05/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import XCTest
@testable import MVP

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
    
}

class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AssemblyModelBuilder()
    
    override func setUp() {
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }

    override func tearDown() {
        router = nil
    }
    
    func testRouter() {
        router.showDetail(comment: nil)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController)
    }

}
