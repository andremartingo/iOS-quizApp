import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    private let options: Dictionary<Question<String>,[String]>
    private let questions: [Question<String>]
    private let correctAnswers: Dictionary<Question<String>,[String]>
    
    init(questions: [Question<String>] , options: Dictionary<Question<String>,[String]>, correctAnswers: Dictionary<Question<String>,[String]>) {
        self.options = options
        self.questions = questions
        self.correctAnswers = correctAnswers
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String])-> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("error")
        }
        switch question {
        case .singleAnswer(let value):
            return questionViewController(for: question, value: value,allowMultipleSelection: false, options: options, answerCallback: answerCallback)
        case .multipleAnswer(let value):
            let controller = questionViewController(for: question, value: value, allowMultipleSelection: true, options: options, answerCallback: answerCallback) 
            return controller
        }
    }
    
    private func questionViewController(for question: Question<String>, value: String, allowMultipleSelection : Bool , options: [String], answerCallback: @escaping ([String])-> Void) -> QuestionViewController{
        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller = QuestionViewController(question: value, options: options , allowMultipleSelection : allowMultipleSelection , selection:answerCallback)
        controller.title = presenter.title
        return controller
    }
    
    func resultsViewController(for result: Result<Question<String>,[String]  >) -> UIViewController{
        let presenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        return ResultViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
    }
}

