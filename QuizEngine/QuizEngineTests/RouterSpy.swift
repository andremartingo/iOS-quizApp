import Foundation
import XCTest
@testable import QuizEngine

class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestions: [String] = []
        var routedResult: Result<String,String>? = nil
        var answerCallback: (String) -> Void   = {_ in}
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void ) {
            routedQuestionCount += 1
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: Result<String,String>){
            routedResult = result
        }
    }
