import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    let question = Question.singleAnswer("Q1")
    let options = ["A1","A2"]
    
    func test_questionViewController_createsController(){
        let sut = makeSUT(options: [question:options])
        
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: {_ in}) as? QuestionViewController
        
        XCTAssertNotNil(controller)
    }
    
    func test_questionViewController_createsControllerWithOptions(){
        let sut = makeSUT(options: [question:options])

        let controller = sut.questionViewController(for: question, answerCallback: {_ in}) as! QuestionViewController
        
        XCTAssertEqual(controller.options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithQuestion(){
        let multipleQuestion = Question.multipleAnswer("Q1")
        let options = ["A1","A2"]
        let sut = makeSUT(options: [multipleQuestion:options])

        let controller = sut.questionViewController(for: multipleQuestion, answerCallback: {_ in}) as! QuestionViewController
        
        XCTAssertEqual(controller.question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection(){
        let multipleQuestion = Question.multipleAnswer("Q1")
        let options = ["A1","A2"]
        let sut = makeSUT(options: [multipleQuestion:options])
        
        let controller = sut.questionViewController(for: multipleQuestion, answerCallback: {_ in}) as! QuestionViewController
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
        
    }
    //MARK: Helpers
    func makeSUT(options: Dictionary<Question<String>,[String]>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
}
