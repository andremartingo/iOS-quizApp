import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (Set<String>)-> Void) -> UIViewController
    func resultsViewController(for result: Result<Question<String>,Set<String>>) -> UIViewController
}
