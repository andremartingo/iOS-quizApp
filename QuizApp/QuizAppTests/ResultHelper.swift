import Foundation
import QuizEngine

extension Result: Hashable {
    
    init(answers: [Question:Answer], score: Int) {
        self.answers = answers
        self.scoring = score
    }
    
    public var hashValue: Int {
        return 1
    }
    
    public static func ==(lhs:Result<Question,Answer>,rhs: Result<Question,Answer>) -> Bool {
        return lhs.scoring == rhs.scoring
    }
}
