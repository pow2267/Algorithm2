//
//  [프로그래머스] k개의 수를 제거하여 가장 큰 수 만들기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/42883
//

import Foundation

func solution(_ number: String, _ k: Int) -> String {
    var numbers: [Character] = number.map({ $0 })
    var index = 0
    var delete = 0
    var stack: [Character] = []
    
    // 문제 자체가 숫자의 순서를 섞지 않고 중간중간 숫자만 제거하는 형태이므로
    // 삭제된 숫자가 k개가 되거나, numbers의 모든 숫자를 순회할 때까지 반복
    while delete < k && index < numbers.count {
        if let last = stack.last {
            // 새로운 index요소 값이 stack의 마지막 값보다 클 때
            if numbers[index] > last {
                // stack의 마지막 요소 제거
                stack.removeLast()
                // 삭제된 숫자 개수 1 추가
                delete += 1
                continue
            }
            
            stack.append(numbers[index])
            index += 1
        } else {
            // result가 빈 배열일 때는 index 요소 값 추가
            stack.append(numbers[index])
            index += 1
        }
    }
    
    // k개의 숫자를 삭제했으나, index가 numbers의 모든 요소를 순회하지 못했을 때
    // 결과값은 항상 numbers.count-k개여야 하므로
    // index이후의 요소들을 모두 추가해준다.
    if delete == k {
        stack.append(contentsOf: numbers[index...])
    }
    
    // index가 numbers의 모든 요소를 순회했으나, 아직 k개 만큼의 숫자를 삭제하지 못했을 때
    // 현재 stack에는 원래 목표보다 k-delete만큼 숫자가 더 들어가 있는 상태
    // 문제에서 제시한 조건은 요소를 앞에서부터 순차적으로 붙여서 숫자로 만들기 때문에
    // stack의 뒤에서 (k-delete)개를 빼준다.
    if index == numbers.count {
        stack = Array(stack[0..<number.count-(k-delete)])
    }
    
                    // character라서 이렇게 붙여줘도 string이 됨
    return stack.reduce("", {"\($0)\($1)"})
}
