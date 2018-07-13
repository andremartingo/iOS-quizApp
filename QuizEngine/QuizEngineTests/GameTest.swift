import Foundation
import XCTest
@testable import QuizEngine

class GameTest: XCTestCase {
    func test_startGame_answerOneOutTwoCorrectly_scores1(){
        let router = RouterSpy()
        startGame(questions: ["Q1","Q2"], router: router, correctAnswers: ["Q1":"A1","Q2":"A2"])
        
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.scoring, 1)
    }
}
