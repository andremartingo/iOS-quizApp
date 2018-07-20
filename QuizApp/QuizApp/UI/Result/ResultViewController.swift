import UIKit

class ResultViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var summary = ""
    private(set) var answers = [PresentableAnswer]()
 
    convenience init(summary: String, answers: [PresentableAnswer]){
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = summary
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WrongAnswerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return AnswerCellBuilder.build(answer: answers[indexPath.row], tableView: tableView).tableViewCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return answers[indexPath.row].wrongAnswer == nil ? 70 : 90
    }
}

class AnswerCellBuilder {
    static func build(answer:PresentableAnswer, tableView: UITableView) -> AnswerCell {
        if answer.wrongAnswer == nil {
            return CorrectAnswerTableViewCell(answer: answer, tableView: tableView)
        }
        return WrongAnswerTableViewCell(answer: answer, tableView: tableView)
    }
}

protocol AnswerCell {
    var tableViewCell: UITableViewCell { get }
}

class AnswerTableViewCell {
    let answer:PresentableAnswer
    let tableView: UITableView

    init(answer:PresentableAnswer, tableView: UITableView) {
        self.answer = answer
        self.tableView = tableView
    }
}

class WrongAnswerTableViewCell: AnswerTableViewCell, AnswerCell {

    var tableViewCell: UITableViewCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
}

class CorrectAnswerTableViewCell: AnswerTableViewCell, AnswerCell {

    var tableViewCell: UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
}
