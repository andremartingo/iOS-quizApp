import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest : XCTestCase {
    
    func test_viewDidLoad_rendersQuestionHeaderText(){
        let sut = makeSUT(question: "Q1", options: [])

        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions(){
        let sut = makeSUT(question: "Q1", options: [])

        XCTAssertEqual(sut.tableView.numberOfRows(inSection:0), 0)
    }
    
    func test_viewDidLoad_OneOption_rendersOneOptions(){
        let sut = makeSUT(question: "Q1", options: ["A1"])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection:0), 1)
    }
    
    func test_viewDidLoad_OneOption_rendersOneOptionText(){
        let sut = makeSUT(question: "Q1", options: ["A1"])
                
        XCTAssertEqual(sut.tableView.title(at: 0), "A1")
    }
    
    func test_optionSelected_notifiesDelegate(){
        //Given
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1"]) {
            receivedAnswer = $0
        }

        //When
        sut.tableView.select(row: 0)
        
        //Then
        XCTAssertEqual(receivedAnswer, ["A1"])
    }
    
    func test_optionSelected_withTwoOptions_notifiesDelegateWithLastSelection(){
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])


    }
    
    func test_optionSelected_withMultipleSelectionEnable_notifiesDelegateSelection(){
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1","A2"])
    }
    
    func test_optionDeselected_withSingleSelection_DoesNotNotifyDelegateWithEmptySelection(){
        var receivedAnswer = [String]()
        var callbackCount = 0
        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
            callbackCount += 1
        }

        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionDeselected_withMultipleSelectionEnable_notifiesDelegateSelection(){
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    // MARK: Helpers
    func makeSUT(question: String = "",
                 options: [String],
                 selection: @escaping ([String]) -> Void = {_ in}) -> QuestionViewController {
        let questionType = Question.singleAnswer(question)
        let factory = iOSViewControllerFactory(options: [questionType:options])
        let sut = factory.questionViewController(for: questionType, answerCallback: selection) as! QuestionViewController
        _ = sut.view
        return sut
    }
}


