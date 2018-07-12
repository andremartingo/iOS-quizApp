 import Foundation

protocol Router{
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question:Question, answerCallback: @escaping (Answer)->Void)
    func routeTo(result: [Question:Answer])
}

 class Flow<Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let router: R
    private let questions:[Question]
    private var result: [Question:Answer] = [:]
    
    init(questions: [Question], router: R) {
        self.questions = questions
        self.router = router
    }
    
    func start(){
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: [:])
        }

    }
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] answer in
            guard let strongSelf = self else {return}
            strongSelf.routeNext(question,answer)
        }
    }
    
    
    private func routeNext(_ question: Question,_ answer: Answer){
        result[question] = answer
        guard let currentQuestionIndex = questions.index(of: question) else {return}
        let nextQuestionIndex = currentQuestionIndex+1
        if nextQuestionIndex < questions.count{
            let nextQuestion = questions[nextQuestionIndex ]
            router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
        }else{
            router.routeTo(result: result)
        }
    }
}
