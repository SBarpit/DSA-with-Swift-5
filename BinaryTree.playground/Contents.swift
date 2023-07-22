import Foundation

public class BinaryNode<Element> {
    var value: Element
    var leftChild: BinaryNode?
    var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
}

extension BinaryNode: CustomStringConvertible {

  public var description: String {
    diagram(for: self)
  }

  private func diagram(for node: BinaryNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.leftChild == nil && node.rightChild == nil {
      return root + "\(node.value)\n"
    }
    return diagram(for: node.rightChild,
                   top + " ", top + "┌──", top + "│ ")
         + root + "\(node.value)\n"
         + diagram(for: node.leftChild,
                   bottom + "│ ", bottom + "└──", bottom + " ")
  }
}

var tree: BinaryNode<Int> {
  let zero = BinaryNode(value: 0)
  let one = BinaryNode(value: 1)
  let five = BinaryNode(value: 5)
  let seven = BinaryNode(value: 7)
  let eight = BinaryNode(value: 8)
  let nine = BinaryNode(value: 9)
  seven.leftChild = one
  one.leftChild = zero
  one.rightChild = five
  seven.rightChild = nine
  nine.leftChild = eight
  return seven
}

print(tree)

//MARK: - Traversal algorithms
// In-Order-Traversal
// Pre-Order-Traversal
// Post-Order-Traversal
//Each one of these traversal algorithms has both a time and space complexity of O(n).

//MARK: In-Order-Traversal
// LeftChild -> Root -> RightChild

public extension BinaryNode {
    func traverseInOrder(visit: (Element) -> ()) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
}


//tree.traverseInOrder { print($0) }

//MARK: Pre-Order Traversal
// Root -> LeftChild -> RightChild

public extension BinaryNode {
    func traversePreOrder(visit: (Element) -> ()) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
}

//tree.traversePreOrder { print($0)}

//MARK: Post-Order Traversal
// LeftChild -> RightChild -> Root

public extension BinaryNode {
    func traversePostOrder(visit: (Element) -> ()) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

//tree.traversePostOrder { print($0)}
