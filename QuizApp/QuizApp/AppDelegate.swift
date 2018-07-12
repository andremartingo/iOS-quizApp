import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let answers = [PresentableAnswer(question: "Question??Question??Question??Question??Question??Question??Question??", answer:"Yeah!Yeah!Yeah!Yeah!Yeah!Yeah!Yeah!Yeah!Yeah!",wrongAnswer:nil),
                       PresentableAnswer(question: "Another Question??", answer:"Hell Yeah!",wrongAnswer:"Hell No!")]
        let viewController = ResultViewController(summary: "You got 1/2 Correct", answers: answers)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
