import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class QuestionPresenterTest: XCTestCase {
    
    let question1 = Question.singleAnswer("Q1")
    let question2 = Question.singleAnswer("Q2")
    
    func test_title_forFirstQuestion_formatsTitleForIndex(){
        let sut = QuestionPresenter(questions: [question1], question: question1)
        
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forUnexistentQuestion_formatsTitleForIndex(){
        let sut = QuestionPresenter(questions: [question1], question: question2)
        
        XCTAssertEqual(sut.title, "")
    }
}
