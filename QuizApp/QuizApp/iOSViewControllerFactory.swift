import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    private let options: Dictionary<Question<String>,[String]>
    private let questions: [Question<String>]
    
    init(questions: [Question<String>] , options: Dictionary<Question<String>,[String]>) {
        self.options = options
        self.questions = questions
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String])-> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("error")
        }
        switch question {
        case .singleAnswer(let value):
            return questionViewController(for: question, value: value, options: options, answerCallback: answerCallback)
        case .multipleAnswer(let value):
            let controller = questionViewController(for: question, value: value, options: options, answerCallback: answerCallback)
            _ = controller.view
            controller.tableView.allowsMultipleSelection = true
            return controller
        }
    }
    
    private func questionViewController(for question: Question<String>, value: String, options: [String], answerCallback: @escaping ([String])-> Void) -> QuestionViewController{
        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller = QuestionViewController(question: value, options: options , selection:answerCallback)
        controller.title = presenter.title
        return controller
    }
    func resultsViewController(for result: Result<Question<String>,[String]  >) -> UIViewController{
        return UIViewController()
    }
}

