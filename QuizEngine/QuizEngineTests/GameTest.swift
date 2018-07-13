import Foundation
import XCTest
@testable import QuizEngine

class GameTest: XCTestCase {
    
    let router = RouterSpy()
    var game: Game<String,String,RouterSpy>!
    
    override func setUp() {
        super.setUp()
        
        game = startGame(questions: ["Q1","Q2"], router: router, correctAnswers: ["Q1":"A1","Q2":"A2"])
    }
    
    func test_startGame_answerOneOutTwoCorrectly_scores1(){
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.scoring, 1)
    }
    
    func test_startGame_answerZeroOutTwoCorrectly_scores0(){
        router.answerCallback("wrong")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.scoring, 0)
    }
}

