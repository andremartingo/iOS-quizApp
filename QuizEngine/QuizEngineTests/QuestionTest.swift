import Foundation
import XCTest
@testable import QuizEngine

class QuestionTest: XCTestCase {
    
    func test_hashValue_singleAnswer_returnsTypeHash(){
        let type = "a string"
        
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnsTypeHash(){
        let type = "a string"
        
        let sut = Question.multipleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_equal_isEqual(){
        XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
        XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
    }
    
    func test_equal_isNotEqual(){
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
    }

}
