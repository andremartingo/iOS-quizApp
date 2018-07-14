public struct Result<Question: Hashable,Answer> {
    public let answers: [Question:Answer]
    public let scoring: Int
 }
