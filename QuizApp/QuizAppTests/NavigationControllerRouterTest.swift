import Foundation
import XCTest
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    func test_routeToQuestion_presentsQuestionController(){
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.routeTo(question:"Q1", answerCallback: {_ in})
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    
    func test_routeToQuestionTwice_presentsQuestionController(){
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.routeTo(question:"Q1", answerCallback: {_ in})
        sut.routeTo(question:"Q2", answerCallback: {_ in})
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
}
