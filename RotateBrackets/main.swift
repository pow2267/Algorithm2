//
//  [프로그래머스] 괄호를 한 칸씩 밀면서 올바른 괄호가 형성되는 횟수 구하기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/76502
//

import Foundation

func solution(_ s: String) -> Int {
    var brackets: [String] = []
    
    s.forEach({ brackets.append(String($0)) })
    
    var result = (isCorrect(brackets) ? 1 : 0)
    
    for _ in 1..<brackets.count {
        let first = brackets.removeFirst()
        brackets.append(first)
        result += (isCorrect(brackets) ? 1 : 0)
    }
    
    return result
}

private func isCorrect(_ brackets: [String]) -> Bool {
    var stack: [Int] = []
    
    func bracketToNumber(_ bracket: String) -> Int {
        var number = 0
        
        switch bracket {
            case "(": number = 1
            case "{": number = 2
            case "[": number = 3
            case ")": number = -1
            case "}": number = -2
            case "]": number = -3
            default: number = 0
        }
        
        return number
    }
    
    // (: 1, {: 2, [: 3, ): -1, }: -2, ]: -3
    for bracket in brackets {
        let target = bracketToNumber(bracket)
        
        if let last = stack.last {
            if last > 0 && last + target == 0 {
                stack.removeLast()
            } else {
                stack.append(target)
            }
        } else {
            stack.append(target)
        }
    }
    
    return stack.isEmpty
}
