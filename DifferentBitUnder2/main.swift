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
        var bits = convertInt64ToBits(number)
        
        // number가 짝수일 때
        if number % Int64(2) == 0 {
            result.append(number + 1)
        // number가 홀수일 때
        } else {
            var index = 0
            
            while index < bits.count {
                if bits[index] == 0 {
                    bits[index] = 1
                    bits[index-1] = 0
                    break
                } else {
                    index += 1
                }
            }
            
            // bits에 0이 없을 때
            if index == bits.count {
                bits[index-1] = 0
                bits.append(1)
            }
            
            result.append(convertBitsToInt64(bits))
        }
    }
    
    return result
}

func convertInt64ToBits(_ number: Int64) -> [Int] {
    var bits: [Int] = []
    var num = number
    
    repeat {
        bits.append(Int(num % Int64(2)))
        num = (num / Int64(2))
    } while num != 0
    
    return bits
}

func convertBitsToInt64(_ bits: [Int]) -> Int64 {
    var result: Int64 = 0
    
    for (index, value) in bits.enumerated() {
        if index == 0 {
            result += Int64(value)
        } else {
            var multi: Int64 = 1
            
            for _ in 0..<index {
                multi *= Int64(2)
            }
            
            result += (Int64(value) * multi)
        }
    }
    
    return result
}
