import Foundation
import QuizEngine

struct ResultsPresenter {
    let result : Result<Question<String>, [String]>
    let correctAnswers: Dictionary<Question<String>,[String]>
    
    var summary : String {
        return "You got \(result.scoring)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return result.answers.map { (question,userAnswers) in
            guard let correctAnswer = correctAnswers[question] else {
                fatalError("could find correct answer for \(question)")
            }
            return presentableAnswer(question, userAnswers, correctAnswer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctAnswer),
                wrongAnswer: formattedWrongAnswer(correctAnswer,userAnswer))
        }
    }
    
    private func formattedAnswer(_ answer: [String]) -> String{
     return answer.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ correctAnswer:[String], _ userAnswer:[String]) -> String? {
        return correctAnswer == userAnswer ? nil : userAnswer.joined(separator: ", ")
    }
}
