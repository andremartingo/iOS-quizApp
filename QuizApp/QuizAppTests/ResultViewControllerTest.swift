import Foundation
import XCTest
@testable import QuizApp

class ResultViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary(){
        let sut = makeSUT(summary: "A summary")
        
        XCTAssertEqual(sut.headerLabel.text, "A summary")
    }
    
    func test_viewDidLoad_withoutAnswers_doesNotRenderAnswers(){
        let sut = makeSUT(summary: "A summary")
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneAnswer_RenderAnswers(){
        let sut = makeSUT(summary: "A summary", answers: [makeAnswer()])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderCorrectAnswerCell(){
        let correctAnswer = makeAnswer()
        let sut = makeSUT(answers: [correctAnswer])
        
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell(){
        let wrongAnswer = makeAnswer(wrongAnswer: "wrong")
        let sut = makeSUT(answers: [wrongAnswer])
        
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderQuestionText(){
        let correctAnswer = makeAnswer(question:"Q1")
        let sut = makeSUT(answers: [correctAnswer])

        let cell = sut.tableView.cell(at: 0) as! CorrectAnswerCell

        XCTAssertEqual(cell.questionLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderAnswerText(){
        let correctAnswer = makeAnswer(answer:"A1")
        let sut = makeSUT(answers: [correctAnswer])
        
        let cell = sut.tableView.cell(at: 0) as! CorrectAnswerCell
        
        XCTAssertEqual(cell.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withCorrectAnswer_configureCell(){
        let correctAnswer = makeAnswer(question:"Q1",answer:"A1")
        let sut = makeSUT(answers: [correctAnswer])
        
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configureCell(){
        let correctAnswer = makeAnswer(question:"Q1",answer:"A1",wrongAnswer: "wrong")
        let sut = makeSUT(answers: [correctAnswer])
        
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")

    }
    
    // MARK: HELPERS
    
    //SUT = System Under Test
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController{
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view //Load view
        return sut
    }

    
    func makeAnswer(question: String = "", answer: String = "" ,wrongAnswer: String? = nil) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer,wrongAnswer: wrongAnswer)
    }
}



