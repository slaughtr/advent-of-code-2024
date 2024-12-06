import Foundation

let inputFile = "input.txt"

func parseInput(fromFile file: String) -> ([Int], [Int]) {
    print("Trying to parse that input file teehee")

    var leftCol: [Int] = []
    var rightCol: [Int] = []

    do {
        let contents: String = try String(contentsOfFile: file, encoding: .utf8)
        let lines = contents.components(separatedBy: .newlines)
        // 0

        for line in lines {
            // 3 spaces separates left and right col in the input
            let cols: [String] = line.components(separatedBy: "   ")
            if let left = Int(cols[0]), let right = Int(cols[1]) {
                leftCol.append(left)
                rightCol.append(right)
            }
        }
    } catch {
        print("Error loading input file")
    }
    
    let sortedLeftCol = leftCol.sorted()
    let sortedRightCol = rightCol.sorted() 

    return (sortedLeftCol, sortedRightCol)
}

let (leftCol, rightCol) = parseInput(fromFile: inputFile)

var numbers = Dictionary(uniqueKeysWithValues: zip(leftCol, rightCol))
var total: Int = 0
for (left, right) in numbers {
    let diff = abs(left - right)
    total += diff
}

print("part one total: \(total)")

// part two

let columns = [leftCol, rightCol]
var occurences: [Int: Int] = Dictionary(minimumCapacity: 10000)
var partTwoTotal: Int = 0

for left in leftCol {
    occurences.updateValue(0, forKey: left)
    for right in rightCol {
        if right == left {
            let current: Int? = occurences[left]
            let next = current! + 1
            occurences.updateValue(next, forKey: left)
        }
    }
}

for (left, _) in occurences {
   partTwoTotal += (left * occurences[left]!) 
}

print(partTwoTotal)

