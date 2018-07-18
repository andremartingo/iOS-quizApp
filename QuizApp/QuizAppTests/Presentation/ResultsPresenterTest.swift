import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class ResultsPresenterTest: XCTestCase {
    
    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers: Dictionary<Question<String>,Set<String>> = [Question.singleAnswer("Q1"):["A1"], Question.multipleAnswer("Q2"):["A2","A3"]]
        let result = Result(answers: answers, score: 1)
        
        let sut = ResultsPresenter(result: result, questions: [Question.singleAnswer("Q1"),Question.multipleAnswer("Q2")] ,correctAnswers: [:])

        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let answers: Dictionary<Question<String>,Set<String>> = Dictionary<Question<String>,Set<String>>()
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: [ ], correctAnswers: [:])

        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withOneSingleQuestion_mapAnswer() {
        let answers: Dictionary<Question<String>,Set<String>> = [Question.singleAnswer("Q1"):["A1"]]
        let result = Result(answers: answers, score: 0)
        let correctAnswers: Dictionary<Question<String>,Set<String>> = [Question.singleAnswer("Q1"): ["A2"]]
        
        let sut = ResultsPresenter(result: result,  questions: [Question.singleAnswer("Q1")] , correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count ,1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withOneMultipleQuestion_mapAnswer() {
        let answers: Dictionary<Question<String>,Set<String>> = [Question.singleAnswer("Q1"):["A1","A4"]]
        let correctAnswers: Dictionary<Question<String>,Set<String>> = [Question.singleAnswer("Q1"): ["A2","A3"]]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result,  questions: [Question.singleAnswer("Q1")] , correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count,1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertTrue((sut.presentableAnswers.first!.wrongAnswer?.contains("A1"))!)
        XCTAssertTrue((sut.presentableAnswers.first!.wrongAnswer?.contains("A4"))!)
    }
    
    func test_presentableAnswers_withRightMultipleQuestion_mapAnswer() {
        let answers: Dictionary<Question<String>,Set<String>> = [Question.singleAnswer("Q1"):["A1","A4"]]
        let correctAnswers: Dictionary<Question<String>,Set<String>> = [Question.singleAnswer("Q1"): ["A1","A4"]]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result,  questions: [Question.singleAnswer("Q1")] , correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count,1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, nil)
    }
    
    func test_presentableAnswers_withTwoQuestion_mapOrderAnswer() {
        let answers: Dictionary<Question<String>,Set<String>> = [Question.multipleAnswer("Q2"):["A2"],Question.multipleAnswer("Q1"):["A1","A4"]]
        let correctAnswers: Dictionary<Question<String>,Set<String>> = [Question.multipleAnswer ("Q1"): ["A1","A4"],Question.multipleAnswer("Q2"):["A2"]]
        let orderQuestions = [Question.multipleAnswer("Q1"),Question.multipleAnswer("Q2")]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: orderQuestions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count,2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertTrue(sut.presentableAnswers.first!.answer.contains("A1"))
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)

        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
        XCTAssertTrue(sut.presentableAnswers.first!.answer.contains("A4"))
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
}
