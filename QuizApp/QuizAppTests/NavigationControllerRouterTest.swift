import Foundation
import XCTest
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = FakeNavigationViewController()
    let factory = ViewControllerFactoryStub()
    lazy var sut : NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController,factory: self.factory)
    }()
 
    func test_routeToQuestionTwo_presentsQuestionController(){
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
        
        sut.routeTo(question:"Q1", answerCallback: {_ in})
        sut.routeTo(question:"Q2", answerCallback: {_ in})
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
    
    func test_routeToQuestion_presentsQuestionController(){
        let viewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        
        sut.routeTo(question:"Q1", answerCallback: {_ in})
        
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }
    
    func test_routeToQuestion_presentsQuestionControllerWithRightCallback(){
        var callbackWasFired = false
        sut.routeTo(question:"Q1", answerCallback: {_ in callbackWasFired = true})
        factory.answerCallback["Q1"]!("Anything")
        
        XCTAssertTrue(callbackWasFired)
    }
    
    //Need to override push view controller because animations delay and test fail 
    class FakeNavigationViewController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestion = [String:UIViewController]()
        var answerCallback = [String: (String)-> Void]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestion[question] = viewController
        }
        func questionViewController(for question: String, answerCallback: @escaping (String)-> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestion[question] ?? UIViewController()
        }
    }
}
