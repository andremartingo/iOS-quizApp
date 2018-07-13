import Foundation

func startGame<Question,Answer, R: Router>(questions: [Question], router: R, correctAnswers: [Question:Answer]) where R.Question == Question, R.Answer == Answer {
    
}
