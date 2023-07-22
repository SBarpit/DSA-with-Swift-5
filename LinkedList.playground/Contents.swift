import Foundation

public class Node<Value> {
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

// TO Print the Nodes.
extension Node: CustomStringConvertible {
  public var description: String {
    guard let next = next else {
      return "\(value)"
    }
    return "\(value) -> " + String(describing: next) + " "
  }
}


// LinkedList

public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    // Checking if LL is empty or not
    public var isEmpty: Bool {
        return head == nil
    }
}

// TO print node.
extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}


//MARK: Addition operations
// Push - Insertion on head (Front)
// Append - Insertion from the tail (Back)
// Insert(after: ) - Insertion after given index (Anywhere in LL)


//MARK: Push
// Time Complexity : O(1)

extension LinkedList {
    public mutating func push(_ value: Value) {
        // Initialise the head with new node, and set next of new node to head
        head = Node(value: value, next: head)
        
        // Check if tail is nil, if yes that means the LL was empty previously so now point head to tail since only one node is available.
        if tail == nil {
            tail = head
        }
    }
}

// MARK: Append
// Time Complexity : O(1)

extension LinkedList {
    public mutating func append(_ value: Value) {
        // Checking if LL is empty or not, if yes and simply push the new node and return
        guard !isEmpty else {
            push(value)
            return
        }
        /*
         Since we have to append the new node in the end so we set the next of tail to our new node.
         And after that now our new node is the last node of LL, so the tail will now point to tail.next i.e our new node.
        */
        tail!.next = Node(value: value)
        tail = tail!.next
    }
}

//MARK: Insert(after: )
// Time Complexity : O(i), i = index

extension LinkedList {
    public mutating func insert(after index: Int, _ value: Value) {
        // Checking for empty, if yes then simply push and return
        guard !isEmpty else {
            push(value)
            return
        }
        
        // Variable to start from head
        var currentNode = head
        // Variable to store the index
        var currentIndex = 0
        
        // Loop to iterate until currentNode not become nil and currentIndex < target index.
        while currentNode != nil, currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        // Checking if we not reached to tail, if yes that means we have to append the new node in the end.
        guard currentNode !== tail else {
            append(value)
            return
        }
        
        // Setting currentNode -> Next to the new Inserted Node and setting currentNode -> Next to the current inserted Node -> Next.
        /*
         New value = 6
         new Node = [6], inset after 5
         [5] -> [7]
         [5] -> [6] -> [7]
         */
        currentNode!.next = Node(value: value, next: currentNode?.next)
    }
}

// MARK: Deletion of node from LL
// pop()
// removeLast()
// remove(after: )

//MARK: Pop
// Time Complexity : O(1)

extension LinkedList {
    public mutating func pop() -> Value? {
        defer {
            // Pointing the head to the next of the head
            head = head!.next
            // Checking if isEmpty? if yes then head is nil, so set the tail to nil as no node is left in LL.
            if isEmpty {
                tail = nil
            }
        }
        // Return value first
        return head?.value
    }
}


//MARK: removeLast()
// Time Complexity : O(n)

extension LinkedList {
    public mutating func removeLast() -> Value? {
        // Checking is LL is empty, if yes then return nil
        if isEmpty {
            return nil
        }
        // If LL is only contains head and next of head is nil, then just pop() and return
        guard head!.next != nil else {
            return pop()
        }
        
        // Current pointer pointing to head
        var current = head
        // Previous pointer pointing to head
        var prev = head
        
        // Loop until we the current reached to the tail, i.e current.next = nil
        while let next = current?.next {
            // Set current to the previous node pointer
            prev = current
            // Set Current.next = next of Current's next node's next pointer.
            current?.next = next
        }
        
        // Now since currentNode is pointing to tail so set prev.next to nil which was pointing to current node
        prev?.next = nil
        // Point the tail to the prev node thus now ARC will free the currentNode i.e the last node.
        tail = prev
        
        // Return the value of current Node.
        return current?.value
    }
}

//MARK: remoce(after: )
// Time Complexity : O(i), i = index

extension LinkedList {
    public mutating func remove(after index: Int) -> Value? {
        if isEmpty { return nil }
        
        var current = head
        var currentIndex = 0
        
        while head?.next != nil, currentIndex < index {
            current = current?.next
            currentIndex += 1
        }
        
        defer {
            if current?.next === tail {
                tail = current
            }
            current?.next = current?.next?.next
        }
        return current?.next?.value
    }
}
/*
 
 
var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)
list.push(4)
print("Before removing element: ", list)

list.remove(after: 0)

print("After removing element: ", list)
 
 */

