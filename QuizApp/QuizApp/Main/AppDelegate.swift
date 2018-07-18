import UIKit
import QuizEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var game: Game<Question<String>, Set<String>, NavigationControllerRouter>?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let question1 = Question.singleAnswer("What's Mike's nationality?")
        let question2 = Question.singleAnswer("What's Caios's nationality?")
        let questions = [question1,question2]
        
        let option1 = "Canadian"
        let option2 = "American"
        let option3 = "Greek"
        let options1 = [option1,option2,option3]
        
        let option4 = "Portuguese"
        let option5 = "American"
        let option6 = "Brazilian"
        let options2 = [option4,option5,option6]
        
        let correctAnswers = [question1:Set([option3]), question2: Set([option6])]
        
        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(questions: questions, options: [question1:options1,question2:options2], correctAnswers: correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
        return true
    }
}

