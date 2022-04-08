//
//  [프로그래머스] 2개 이하로 다른 비트의 숫자 중 가장 작은 수 찾기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/77885
//

import Foundation

func solution(_ numbers: [Int64]) -> [Int64] {
    var result: [Int64] = []
    
    numbers.forEach{ number in
        var loop: Bool = true
        var plus: Int64 = 0
                    
        while loop {
            plus += 1
            var num = number
            var newNum = number + plus
            var diffCount = 0
            
            repeat {
                if (Int(num % Int64(2))) != (Int(newNum % Int64(2))) {
                    diffCount += 1
                }
                
                num = (num / Int64(2))
                newNum = (newNum / Int64(2))
            } while (num != 0 && diffCount < 3)
            
            if (Int(num % Int64(2))) != (Int(newNum % Int64(2))) {
                diffCount += 1
            }
            
            if diffCount < 3 {
                result.append(number + plus)
                loop = false
            } else {
                loop = true
            }
        }
    }
    
    return result
}
