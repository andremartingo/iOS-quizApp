import Foundation
import XCTest
import QuizEngine
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
        
        XCTAssertTrue(controller.allowMultipleSelection)
        
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithTitle(){
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion,multipleAnswerQuestion], question: multipleAnswerQuestion)
        let sut = makeSUT(options: [multipleAnswerQuestion:options])
        let controller = sut.questionViewController(for: multipleAnswerQuestion, answerCallback: {_ in}) as! QuestionViewController

        XCTAssertEqual(controller.title, presenter.title)
    }
    
    func test_resultsViewController_createsController(){
        let results = makeResults()
        
        let controller = results.controller
        
        XCTAssertNotNil(controller)
    }
    
    
    func test_resultsViewController_createsControllerWithSummary(){
        let results = makeResults()
        
        let presenter = results.presenter
        
        let controller = results.controller
        XCTAssertNotNil(controller.summary, presenter.summary)
    }
    
    func test_resultsViewController_createsControllerWithPresentableAnswers(){
        let results = makeResults()
        
        let presenter = results.presenter
        
        let controller = results.controller
        
        XCTAssertEqual(controller.answers.count, presenter.presentableAnswers.count)
    }
    //MARK: Helpers
    func makeSUT(options: Dictionary<Question<String>,[String]>,correctAnswers: Dictionary<Question<String>,[String]> = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion,multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    }
    
    func makeResults() -> (controller: ResultViewController, presenter: ResultsPresenter) {
        let userAnswers = [singleAnswerQuestion:["A1"], multipleAnswerQuestion: ["A1","A2"]]
        let correctAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1","A2"]]
        let questions = [singleAnswerQuestion,multipleAnswerQuestion]
        let result = Result(answers: userAnswers, score: 2)
        
        let presenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let sut = makeSUT(options: [:], correctAnswers: correctAnswers)
        
        let controller = sut.resultsViewController(for: result) as! ResultViewController
        return (controller,presenter)
    }
    
}
