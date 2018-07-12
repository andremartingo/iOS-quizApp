import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRoutetoQuestion(){
        let sut = makeSUT(questions: [])
        sut.start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestions_routetoQuestion(){
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routetoCorrectQuestion(){
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routetoFirstQuestion(){
        let sut = makeSUT(questions: ["Q1","Q2"])
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routetoFirstQuestionTwice(){
        let sut = makeSUT(questions: ["Q1","Q2"])
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routeToSecondQuestion(){
        let sut = makeSUT(questions: ["Q1","Q2"])
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routeToSecondAndThirdQuestion(){
        let sut = makeSUT(questions: ["Q1","Q2","Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2","Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToSecondQuestion(){
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1" ])
    }
    
    func test_start_withNoQuestions_routesToResult(){
        let sut = makeSUT(questions: [])
        sut.start()
        XCTAssertEqual(router.routedResult!,[:])
    }
    
    
    func test_start_WithOneQuestion_doesNotRouteToResult(){
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        XCTAssertNil(router.routedResult)
    }
    
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_routesToResult(){
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedResult!, ["Q1":"A1"])
    }
    
    //MARK: Helpers
    
    func makeSUT(questions: [String]) -> Flow<String,String,RouterSpy> {
        return Flow(questions: questions, router: router)
    }
    
    
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestions: [String] = []
        var routedResult: [String:String]? = nil
        var answerCallback: (String) -> Void   = {_ in}
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void ) {
            routedQuestionCount += 1
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String:String]){
            routedResult = result
        }
    }
}

