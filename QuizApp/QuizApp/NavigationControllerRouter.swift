import UIKit
import QuizEngine


enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    var hashValue: Int {
        switch self {
        case .singleAnswer(let value):
            return value.hashValue
        case .multipleAnswer(let value):
            return value.hashValue
        }
    }
    
    static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs,rhs) {
        case (.singleAnswer(let a), .singleAnswer(let b)):
            return a == b
        case (.multipleAnswer(let a), .multipleAnswer(let b)):
            return a == b
        default:
            return false
        }
    }
}
protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallback: @escaping (String)-> Void) -> UIViewController
}

class NavigationControllerRouter: Router {
    let navigationController: UINavigationController
    let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question:String, answerCallback: @escaping (String)->Void){
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }
    func routeTo(result: Result<String,String>){
        
    }
}
