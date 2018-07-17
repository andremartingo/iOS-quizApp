import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    let options = ["A1","A2"]
    
    func test_questionViewController_createsController(){
        let sut = makeSUT(options: [singleAnswerQuestion:options])
        
        let controller = sut.questionViewController(for: singleAnswerQuestion, answerCallback: {_ in}) as? QuestionViewController
        
        XCTAssertNotNil(controller)
    }
    
    func test_questionViewController_createsControllerWithOptions(){
        let sut = makeSUT(options: [singleAnswerQuestion:options])

        let controller = sut.questionViewController(for: singleAnswerQuestion, answerCallback: {_ in}) as! QuestionViewController
        
        XCTAssertEqual(controller.options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithQuestion(){
        let options = ["A1","A2"]
        let sut = makeSUT(options: [multipleAnswerQuestion:options])

        let controller = sut.questionViewController(for: multipleAnswerQuestion, answerCallback: {_ in}) as! QuestionViewController
        
        XCTAssertEqual(controller.question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection(){
        let options = ["A1","A2"]
        let sut = makeSUT(options: [multipleAnswerQuestion:options])
        
        let controller = sut.questionViewController(for: multipleAnswerQuestion, answerCallback: {_ in}) as! QuestionViewController
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
        
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithTitle(){
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion,multipleAnswerQuestion], question: multipleAnswerQuestion)
        let sut = makeSUT(options: [multipleAnswerQuestion:options])
        let controller = sut.questionViewController(for: multipleAnswerQuestion, answerCallback: {_ in}) as! QuestionViewController

        XCTAssertEqual(controller.title, presenter.title)
    }
    
    //MARK: Helpers
    func makeSUT(options: Dictionary<Question<String>,[String]>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion,multipleAnswerQuestion], options: options)
    }
    
}
