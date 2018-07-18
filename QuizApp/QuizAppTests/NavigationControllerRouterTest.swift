import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    
    let navigationController = FakeNavigationViewController()
    let factory = ViewControllerFactoryStub()
    lazy var sut : NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController,factory: self.factory)
    }()
 
    func test_routeToQuestionTwo_presentsQuestionController(){
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question:Question.singleAnswer("Q2"), with: secondViewController)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: {_ in})
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: {_ in})
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
    
    func test_routeToQuestion_presentsQuestionController(){
        let viewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: {_ in})
        
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }
    
    func test_routeToResult_showsResultController(){
        let viewController = UIViewController()
        let result = Result(answers: [singleAnswerQuestion:["A1"]], score: 10)
        factory.stub(result: result, with: viewController)
        
        sut.routeTo(result: result)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }
    
    func test_routeToQuestion_presentsQuestionControllerWithRightCallback(){
        var callbackWasFired = false
        sut.routeTo(question: singleAnswerQuestion, answerCallback: {_ in callbackWasFired = true})
        factory.answerCallback[singleAnswerQuestion ]!(["Anything"])
        
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routeToQuestion_multipleAnswer_presentsQuestionControllerWithRightCallback(){
        var callbackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: {_ in callbackWasFired = true})
        factory.answerCallback[multipleAnswerQuestion]!(["Anything"])
        
        XCTAssertFalse(callbackWasFired)
    }
    
    
    func test_routeToQuestion_multipleAnswerSubmitButton_isDisableWhenZeroAnswerSelected(){
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        sut.routeTo(question:multipleAnswerQuestion, answerCallback: {_ in })
    
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
    }

    func test_routeToQuestion_multipleAnswerSubmitButton_progressToNextQuestion(){
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        var callbackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: {_ in callbackWasFired = true })
        factory.answerCallback[ multipleAnswerQuestion]!(["A1"])
        viewController.navigationItem.rightBarButtonItem!.simulateTap()
        
        XCTAssertTrue(callbackWasFired)
        
    }
    
    //MARK: Helpers
    
    //Need to override push view controller because animations delay and test fail 
    class FakeNavigationViewController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestion = Dictionary<Question<String>,UIViewController>()
        private var stubbedResults = Dictionary<Result<Question<String>,[String]>,UIViewController>()
        var answerCallback = Dictionary<Question<String>, ([String]) -> Void> ()
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestion[question] = viewController
        }
        
        func stub(result: Result<Question<String>,[String]>, with viewController: UIViewController) {
            return stubbedResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String])-> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestion[question] ?? UIViewController()
        }
        
        func resultsViewController(for result: Result<Question<String>,[String]>) -> UIViewController{
            return stubbedResults[result] ?? UIViewController()
        }
    }
}

private extension UIBarButtonItem {
    func simulateTap(){
        target?.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}

